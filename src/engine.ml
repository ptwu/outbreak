open Virus
open World
open Country

type t = { virus : Virus.t; world : World.t }

let init_state = { virus = Virus.init_virus; world = World.init_world }

let step_cure_progress w =
  { w with cure_progress = w.cure_progress +. w.cure_rate }

let step_cure_rate w = { w with cure_rate = w.cure_rate *. 1.1 }

(** [(/./) a b] is the floating division of b by a. *)
let ( /./ ) a b = b /. a

(** [step_kill v w] is the resulting world state after one tick of death
    simulation has passed for all countries in [st]. *)
let step_kill { hality } w =
  let chance = hality |> float_of_int |> ( /./ ) 100.0 in
  let round n =
    n |> float_of_int |> ( *. ) chance |> ceil |> int_of_float
  in
  let killed c = infected c |> round |> kill c in
  { w with countries = w.countries |> List.map killed }

(** [step_infect v w] is the resulting world state after one tick of infection
    simulation has passed for all countries in [st]. *)
let step_infect { infectivity } w =
  let chance = infectivity |> float_of_int |> ( /./ ) 100.0 in
  let round n =
    n |> float_of_int |> ( *. ) chance |> ceil |> int_of_float
  in
  let infected c = healthy c |> round |> infect c in
  { w with countries = w.countries |> List.map infected }

(** [step_spread v w] is the resulting world state after one tick of spreading
    simulation has passed for all countries in [st]. *)
let step_spread { infectivity } w =
  let { countries } = w in
  let roll_dry { dry } =
    let chance, neighbors = dry in
    let helper a c =
      if List.mem c.id neighbors && c.population.infected > 0 then 1
      else 0
    in
    let bad_neighbors = List.fold_left helper 0 countries in
    (* if bordering countries are infected, then land infection more likely *)
    Random.int 100 + infectivity < bad_neighbors * chance
  in
  let roll_sea { sea } = Random.int 100 + infectivity < sea in
  let roll_air { air } = Random.int 100 + infectivity < air in
  let spread roll c = if roll c.borders then infect c 1 else c in
  {
    w with
    countries =
      countries
      |> List.map (spread roll_dry)
      |> List.map (spread roll_sea)
      |> List.map (spread roll_air);
  }

(** [step_once st] is the resulting world state after one tick of
    simulation has passed for [st]. *)
let step_once { virus; world } =
  {
    virus;
    world =
      world |> step_cure_progress |> step_cure_rate |> step_kill virus
      |> step_infect virus |> step_spread virus;
  }

let rec step n st = if n <= 0 then st else st |> step_once |> step (n - 1)

let status { world } =
  Printf.sprintf "Healthy: %d\nInfected: %d\nDead: %d\nCure Progress: %f out of %d\n\n"
    (world_healthy_pop world)
    (world_infected_pop world)
    (world_dead_pop world)
    (world |> cure_progress)
    (100)
