(** Representation of dynamic game state. *)

(** Representation type for a certain game's status. *)
type status = Init | Playing | Done of bool * float

(** Representation type for a certain game's state. *)
type t = {
  virus : Virus.t;
  world : World.t;
  shop : Upgrades.t;
  status : status
}

(** [step l st] is the resulting game state after [l] ticks have passed from [st]. *)
val step : int -> t -> t

(** [status_str st] is a formatted string describing the status of [st]. *)
val status_str : t -> string

(** [step l st] is the resulting game state after [l] ticks have passed from [st]. *)
val purchase : string -> t -> t

(** [init name cid st] is the resulting game state with virus name [name]
    and starting country [cid] *)
val init : string -> Country.country_id -> t -> t