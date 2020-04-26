(** Representation type for a certain game's state. *)
type t = {
  virus : Virus.t;
  world : World.t
}

(** [init_state] is an Engine type that represents the initial state of
    an Outbreak game. *)
val init_state : t

(** [step l st] is the resulting game state after [l] ticks have passed from [st]. *)
val step : int -> t -> t

(** [status st] is a formatted string describing the status of [st]. *)
val status : t -> string
