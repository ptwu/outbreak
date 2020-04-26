(** The representation type for the stats of a virus. *)
type stats = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
}

(** The representation type for a virus upgrade. *)
type upgrade = { id : string; name : string; stats : stats; cost : int }

(** The representation type for a virus. *)
type t = {
  name : string;
  stats : stats;
  upgrades : string list;
  points : int;
}


(** [init_virus] is a virus with initial stats. *)
val init_virus : t

(** [init_upgrades] is a list of initial virus upgrades. *)
val init_upgrades : upgrade list

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
val upgrade : upgrade -> t -> t
