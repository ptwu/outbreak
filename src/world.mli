(** Representation of world game model. *)

(** [t] is the type representing a world:
      [countries]: a list of countries in the world
      [cure_progress]: the amount of progress made on a cure
      [cure_rate]: the rate at which cure progress progresses
*)
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

(** [world_healthy_pop w] is the healthy population in [w]*)
val world_healthy_pop : t -> int

(** [world_infected_pop w] is the infected population in [w]*)
val world_infected_pop : t -> int

(** [world_dead_pop w] is the dead population in [w]*)
val world_dead_pop : t -> int

(** [world_pop w] is a record containing the healthy, infected, and dead populations in [w]*)
val world_pop : t -> Country.population

(** [infect_country cid w] is the world [w] with country [cid]
    infected by [n] additional people. *)
val infect_country : Country.country_id -> int -> t -> t

(** [score w] is the player's score, calculated with the world infected and dead population along with cure progress*)
val score : t -> float