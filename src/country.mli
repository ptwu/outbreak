type country_id = string

type info = {
  name : string;
  temperature : int;
  health_care : int;
  density : int;
}

type border = DRY | SEA | AIR

type population = { healthy : int; infected : int; dead : int }

type accessibility = { dry : int * country_id list; sea : int; air : int }

type t = {
  id : country_id;
  info : info;
  population : population;
  borders : accessibility;
}

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
