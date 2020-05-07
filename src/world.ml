open Country

type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
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

let infect_country (id : country_id) (n : int) ({ countries } as w) =
  let inf c = if c.id = id then infect c n else c in
  {
    w with
    countries = List.map inf countries
  }

let score w =
  float (world_infected_pop w + (2 * world_dead_pop w)) -. cure_progress w