open Country

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
  cure_rate = 0.0;
}

let world_from_json json = failwith "unimplemented"

(* Note: current max threshold for cure progress is hardcoded 100 *)
let cure_progress world = world.cure_progress /. 100.0

let world_pop world = 
  world.countries |> List.map total_pop |> List.fold_left (+) 0 

let world_healthy_pop world =
  world.countries |> List.map healthy |> List.fold_left (+) 0 

let world_infected_pop world =
  world.countries |> List.map infected |> List.fold_left (+) 0 

let world_dead_pop world =
  world.countries |> List.map dead |> List.fold_left (+) 0
