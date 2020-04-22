type t

type border

type country_id

val id : t -> country_id

val name : t -> string

val temperature : t -> int

val health_care : t -> int

val density : t -> int

val total_pop : t -> int

val healthy : t -> int

val infected : t -> int

val dead : t -> int

val land_access : t -> int * country_id list

val sea_access : t -> int

val air_access : t -> int

val close_border : t -> border -> t

val infect : t -> int -> t

val recover : t -> int -> t

val kill : t -> int -> t
