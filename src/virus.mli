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

(** The representation type for a virus. *)
type t = {
  stats : stats;
  upgrades : string list;
  points : int;
}

(** The representation type for a virus upgrade. *)
type upgrade = stats
    
(** [init_virus] represents a virus with default stats. *)
val init_virus : t

(** [empty_upgrade] represents a virus upgrade with empty stats. *)
val empty_upgrade : t

(** [infectivity v] is the infectivity stat of the virus [v] *)
val infectivity : t -> int

val init_virus : t

val empty_upgrade : t

val get_infect : t -> int

val get_sever : t -> int

val get_lethal : t -> int

val get_heat : t -> int

val get_cold : t -> int


(** [upgrade upg_offsets v] takes a current virus [v] and applies a virus
    upgrade stat vector [upg_offsets] to it, returning the resulting
    virus with the [upg_offsets] added to [v] *)
val upgrade : string -> upgrade -> t -> t
