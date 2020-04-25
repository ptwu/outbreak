type t

val init_virus : t

val empty_upgrade : t

val get_infectivity : t -> int

val get_severity : t -> int

val get_lethality : t -> int

val get_heat_res : t -> int

val get_cold_res : t -> int

val get_drug_res : t -> int

val upgrade : t -> t -> t
