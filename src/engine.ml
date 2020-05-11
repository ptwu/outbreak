open Virus
open World
open Country
open Stats
open Upgrades

type status = Init | Playing | Done of bool * float

type t = {
  virus : Virus.t;
  world : World.t;
  shop : Upgrades.t;
  status : status;
}

(** [step_cure_progress w] is the resulting world state after one tick of 
    cure progress simulation has passed for [w]. *)
let step_cure_progress w =
  { w with cure_progress = min 100.0 (w.cure_progress +. w.cure_rate) }

(** [step_cure_rate w] is the resulting world state after one tick of 
    cure rate simulation has passed for [w]. *)
let step_cure_rate w = { w with cure_rate = min 0.2 w.cure_rate *. 1.005 }

(** [step_kill v w] is the resulting world state after one tick of death
    simulation has passed for all countries in [st]. *)
let step_kill { hality } w =
  let m c =
    1. *. float_of_int (infected c + dead c) /. float_of_int (total_pop c)
  in
  let round c n =
    n |> float_of_int |> ( *. ) (hality *. m c) |> ceil |> int_of_float
  in
  let killed c = infected c |> round c |> kill c in
  { w with countries = w.countries |> List.map killed }

(** [step_infect v w] is the resulting world state after one tick of infection
    simulation has passed for all countries in [st]. *)
let step_infect { infectivity } w =
  let m c =
    100.
    *. float_of_int (infected c + dead c)
    /. float_of_int (total_pop c)
  in
  let round c n =
    n |> float_of_int
    |> ( *. ) (infectivity *. m c)
    |> ceil |> int_of_float
  in
  let infected c =
    (if infected c > 0 then healthy c else 0) |> round c |> infect c
  in
  { w with countries = w.countries |> List.map infected }

(** [step_spread v w] is the resulting world state after one tick of spreading
    simulation has passed for all countries in [st]. *)
let step_spread { infectivity } w =
  let { countries } = w in
  let roll_dry { dry } =
    let chance, neighbors = dry in
    let helper a c =
      if c.population.infected > 0 && List.mem c.id neighbors then 1
      else 0
    in
    let bad_neighbors = List.fold_left helper 0 countries in
    (* if bordering countries are infected, then land infection more likely *)
    Random.float 1. -. (infectivity *. 2.)
    < float_of_int bad_neighbors *. chance /. 100000.
  in
  let roll_sea { sea } =
    Random.float 1. -. (infectivity *. 2.) < sea /. 100000.
  in
  let roll_air { air } =
    Random.float 1. -. (infectivity *. 2.) < air /. 100000.
  in
  let spread roll c = if roll c.borders then infect c 1 else c in
  {
    w with
    countries =
      countries
      |> List.map (spread roll_dry)
      |> List.map (spread roll_sea)
      |> List.map (spread roll_air);
  }

(** [update_status st] is the game state with status [Done] if the game is over
    and [Playing] otherwise. *)
let update_status ({ world } as st) =
  let status =
    if world_infected_pop world = 0 && world_infected_pop world = 0 then
      Done (true, score world)
    else if cure_progress world >= 100.0 || world_infected_pop world = 0
    then Done (false, score world)
    else Playing
  in
  { st with status }

(** [step_once st] is the resulting world state after one tick of
    simulation has passed for [st]. *)
let step_once ({ virus; world; status } as st) =
  match status with
  | Init | Done _ -> st
  | Playing ->
      let { stats } = virus in
      let world' =
        world |> step_cure_progress |> step_cure_rate |> step_kill stats
        |> step_infect stats |> step_spread stats
      in
      let rec points _ =
        if Random.int 100 >= 50 then
          ( log (5. +. (stats.infectivity *. 5.) +. (stats.hality *. 10.))
          |> ceil |> int_of_float )
          + Random.int 2 + points ()
        else 0
      in
      {
        st with
        virus = virus |> add_points (points () |> max 0);
        world = world';
      }
      |> update_status

let rec step n st = if n <= 0 then st else st |> step_once |> step (n - 1)

let purchase name ({ virus; shop; status } as st) =
  match status with
  | Init | Done _ -> st
  | Playing -> (
      let comp { id } = id = name in
      match List.find_opt comp shop with
      | None -> st
      | Some u -> { st with virus = upgrade virus u } )

let init (name : string) (cid : country_id)
    ({ virus; world; status } as st : t) =
  match status with
  | Init ->
      {
        st with
        virus = change_name name virus;
        world = infect_country cid 1 world;
        status = Playing;
      }
  | Playing | Done _ -> st

let status_str { world } =
  Printf.sprintf
    "Healthy: %d\nInfected: %d\nDead: %d\nCure Progress: %f out of %d\n\n"
    (world_healthy_pop world)
    (world_infected_pop world)
    (world_dead_pop world) (world |> cure_progress) 100
