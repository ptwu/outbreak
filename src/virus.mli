open Upgrades
open Stats

(** The representation type for a virus. *)
type t = {
  name : string;
  stats : Stats.t;
  upgrades : string list;
  points : int;
}

(** [init_virus] is a virus with initial stats. *)
val init_virus : t

(** [infectivity v] is the infectivity stat of the virus [v] *)
val infectivity : t -> int

val severity : t -> int

val hality : t -> int

val heat_res : t -> int

val cold_res : t -> int

val drug_res : t -> int

val anti_cure : t -> int

val add_points : int -> t -> t

(** [upgrade u v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
val upgrade : t -> upgrade -> t

(** [change_name n v] is [v] with name [n]. *)
val change_name : string -> t -> t