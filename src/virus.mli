type t

val init_virus : t

val getinfect : t -> int

val getsever : t -> int

val getlethal : t -> int

val getheat : t -> int

val getcold : t -> int

val getdrug : t -> int

val upgrade : string -> int -> t -> t