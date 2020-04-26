type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

(** [cure_progress w] is the progress of the cure developing in [w] for the virus *)
val cure_progress : t -> float

val init_world : t

(** [world_pop w] is the total population in [w]*)
val world_pop : t -> int

val world_healthy_pop : t -> int

val world_infected_pop : t -> int

val world_dead_pop : t -> int

val score : t -> float