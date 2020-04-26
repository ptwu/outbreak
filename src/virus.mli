(** The representation type for a virus. *)
type t = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
  upgrades : string list;
}

(** The representation type for an upgrade. *)
type upgrade = t
    
(** [init_virus] represents a virus with default stats. *)
val init_virus : t

(** [empty_upgrade] represents a virus upgrade with empty stats. *)
val empty_upgrade : t

(** [infectivity v] is the infectivity stat of the virus [v] *)
val infectivity : t -> int

(** [severity v] is the severity stat of the virus [v] *)
val severity : t -> int

(** [hality v] is the lethality stat of the virus [v] *)
val hality : t -> int

(** [heat_res v] is the heat resistance stat of the virus [v] *)
val heat_res : t -> int

(** [cold_res v] is the cold resistance stat of the virus [v] *)
val cold_res : t -> int

(** [drug_res v] is the drug resistance stat of the virus [v] *)
val drug_res : t -> int

(** [anti_cure v] is the cure hampering stat of the virus [v] *)
val anti_cure : t -> int

(** [upgrades v] is the  *)
val upgrades : t -> string list

(** [upgrade upg_offsets v] takes a current virus [v] and applies a virus
    upgrade stat vector [upg_offsets] to it, returning the resulting
    virus with the [upg_offsets] added to [v] *)
val upgrade : string -> upgrade -> t -> t
