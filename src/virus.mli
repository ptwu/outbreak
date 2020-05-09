(** Representation of virus game model. *)
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
val infectivity : t -> float

(** [severity v] is is the severity stat of [v]. *)
val severity : t -> float

(** [hality v] is is the hality stat of [v]. *)
val hality : t -> float

(** [heat_res v] is is the heat_res stat of [v]. *)
val heat_res : t -> float

(** [cold_res v] is is the cold_res stat of [v]. *)
val cold_res : t -> float

(** [drug_res v] is is the drug_res stat of [v]. *)
val drug_res : t -> float

(** [anti_cure v] is is the anti_cure stat of [v]. *)
val anti_cure : t -> float

(** [add_points p v] is [v] with [p] additional points. *)
val add_points : int -> t -> t

(** [upgrade u v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
val upgrade : t -> upgrade -> t

(** [change_name n v] is [v] with name [n]. *)
val change_name : string -> t -> t