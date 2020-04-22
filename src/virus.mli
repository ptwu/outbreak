type t

val init_virus : t

val empty_upgrade : t

val get_infect : t -> int

val get_sever : t -> int

val get_lethal : t -> int

val get_heat : t -> int

val get_cold : t -> int

val upgrade : t -> t -> t