type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

val init_world : t

val cure_progress : t -> float

val world_pop : t -> int

val world_healthy_pop : t -> int

val world_infected_pop : t -> int

val world_dead_pop : t -> int
