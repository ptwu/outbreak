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

val init_virus : t

val empty_upgrade : t

val get_infect : t -> int

val get_sever : t -> int

val get_lethal : t -> int

val get_heat : t -> int

val get_cold : t -> int

                    <<<<<<< HEAD
val upgrade : t -> t -> t
                        =======
                        (** [upgrade upg_offsets v] takes a current virus [v] and applies a virus
                            upgrade stat vector [upg_offsets] to it, returning the resulting
                            virus with the [upg_offsets] added to [v] *)
val upgrade : string -> upgrade -> t -> t
  >>>>>>> 1b3524146e929fac0446e82bc8cba77c9b616df0
