(** Representation type for a certain game's state *)
type t = {
  virus : Virus.t;
  world : World.t
}

(** [init_state] is an Engine type that represents the initial state of
    an Outbreak game *)
val init_state : t

(** [step st] is the resultant game state after one tick has passed from [st] *)
val step : t -> t
