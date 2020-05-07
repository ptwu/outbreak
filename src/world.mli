type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

(** [cure_progress w] is the progress of cure development in [w] for the virus *)
val cure_progress : t -> float

(** [cure_rate w] is the rate of the cure development in [w] for the virus *)
val cure_rate : t -> float

(** [world_total_pop w] is the total population in [w]*)
val world_total_pop : t -> int

val world_healthy_pop : t -> int

val world_infected_pop : t -> int

val world_dead_pop : t -> int

val world_pop : t -> Country.population

(** [infect_country cid w] is the world [w] with country [cid]
    infected by [n] additional people. *)
val infect_country : Country.country_id -> int -> t -> t

val score : t -> float