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

let step_kill l w =
  let hality c = kill c (infected c * l / 100) in
  {
    w with
    countries = w.countries |> List.map hality
  }

let step_infect i w =
  let infection c = infect c (healthy c * i / 100) in
  {
    w with
    countries = w.countries |> List.map infection
  }

let step s =
  let hality = hality s.virus in
  let infectivity = infectivity s.virus in
  {
    s with
    world = s.world |> step_cure_progress |> step_cure_rate |> step_kill hality |> step_infect infectivity
  }