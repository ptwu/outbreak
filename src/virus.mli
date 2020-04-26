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

(** default values for a virus with default attributes and an empty upgrade
    virus for use in adding more stats to it by passing it through [upgrade] *)
val init_virus : t
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
    upgrade stat vector [upg_offsets] to it, returning the resultant new
    virus with the [upg_offsets] added to [v] *)
val upgrade : string -> t -> t -> t
