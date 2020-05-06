open Country
open Yojson.Basic.Util

type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

let init_world = {
  countries = [{
      id = "greenland";
      info =
        {
          name = "Greenland";
          temperature = -100;
          health_care = 50;
          density = 10;
        };
      population = { healthy = 300000; infected = 0; dead = 0 };
      borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
    }];
  cure_progress = 0.0;
  cure_rate = 0.001;
}

let cure_rate world =
  world.cure_rate

let cure_progress world =
  world.cure_progress

let world_total_pop w = 
  w.countries |> List.map total_pop |> List.fold_left (+) 0 

let world_healthy_pop w =
  w.countries |> List.map healthy |> List.fold_left (+) 0 

let world_infected_pop w =
  w.countries |> List.map infected |> List.fold_left (+) 0 

let world_dead_pop w =
  w.countries |> List.map dead |> List.fold_left (+) 0

let world_pop w = {
  healthy = world_healthy_pop w;
  infected = world_infected_pop w;
  dead = world_dead_pop w;
}

let score w =
  float (world_infected_pop w + (2 * world_dead_pop w)) -. cure_progress w