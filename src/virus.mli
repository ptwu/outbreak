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

(** [upgrade upg_offsets v] takes a current virus [v] and applies a virus
    upgrade stat vector [upg_offsets] to it, returning the resulting
    virus with the [upg_offsets] added to [v] *)
val upgrade : t -> upgrade -> t
