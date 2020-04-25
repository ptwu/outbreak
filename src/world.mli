(** The representation type for the world. *)
type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

val init_world : t

(** [cure_progress w] is the progress percentage float of the cure 
    developing in [w] for the virus*)
val cure_progress : t -> float

(** [world_pop w] is the total population in [w]*)
val world_pop : t -> int

(** [world_healthy_pop w] is the total healthy population in [w]*)
val world_healthy_pop : t -> int

(** [world_infected_pop w] is the total virus-infected population in 
    [w]*)
val world_infected_pop : t -> int

(** [world_dead_pop w] is the total dead in the population in 
    [w]*)
val world_dead_pop : t -> int

(** [score] is the progress/score of the virus, which takes into account the 
    world's infected and dead population *)
val score : t -> float