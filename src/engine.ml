open Virus
open World
open Country

type t = {
  virus: Virus.t;
  world: World.t;
}

let init_state = {
  virus = Virus.init_virus;
  world = World.init_world;
}

let step_cure_progress w = {
  w with
  cure_progress = w.cure_progress +. w.cure_rate
}

let step_cure_rate w = {
  w with
  cure_rate = w.cure_rate *. 1.1
}

let step_kill { infectivity } w =
  let killed c = kill c (infected c * infectivity / 100) in
  {
    w with
    countries = w.countries |> List.map killed
  }

let step_infect { hality } w =
  let infected c = infect c (healthy c * hality / 100) in
  {
    w with
    countries = w.countries |> List.map infected
  }

let step_spread { infectivity } w =
  let { countries } = w in
  let roll_dry { dry } = 
    let ( chance, neighbors ) = dry in
    let helper a c = if List.mem c.id neighbors && c.population.infected > 0 then 1 else 0 in
    let bad_neighbors = List.fold_left helper 0 countries in
    (* if bordering countries are infected, then land infection more likely *)
    (Random.int 100 + infectivity) < bad_neighbors * chance in
  let roll_sea { sea } = (Random.int 100 + infectivity) < sea in
  let roll_air { air } = (Random.int 100 + infectivity) < air in
  let spread roll c = if roll c.borders then infect c 1 else c in
  {
    w with
    countries = countries |> List.map (spread roll_dry)
                |> List.map (spread roll_sea)
                |> List.map (spread roll_air)
  }

let step { virus; world } =
  {
    virus = virus;
    world = world |> step_cure_progress |> step_cure_rate |> step_kill virus
            |> step_infect virus |> step_spread virus;
  }

let rec step_multi n s =
  if n <= 0 then s else s |> step |> step_multi (n-1)