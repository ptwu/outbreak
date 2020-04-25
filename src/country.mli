(** 
   Representation of the Data for a Country 
*)
type country_id = string

type info = {
  name : string;
  temperature : int;
  health_care : int;
  density : int;
}

type border = LAND | SEA | AIR

type population = { healthy : int; infected : int; dead : int }

(** Accessibility is a record with three fields: [dry], [sea], and [air].
    [dry] is a pair with an accessibility value and list of countries accessible
    by land; [sea] is accessibility to other countries by sea, [air] is
    accessibility to other countries by air. *)
type accessibility = { dry : int * country_id list; sea : int; air : int }

(** [t] is the abstract type representing a certain country *)
type t = {
  id : country_id;
  info : info;
  population : population;
  borders : accessibility;
}

(** [id c] is the id string representing a country [c] *)
val id : t -> country_id

(** [name c] is the name of the country [c] *)
val name : t -> string

(** [temperature c] is the temperature representative of the country [c] *)
val temperature : t -> int

(** [health_care c] is the healthcare index representative of the country [c] *)
val health_care : t -> int

(** [density c] is the density index representative of the country [c] *)
val density : t -> int

(** [total_pop c] is the total population of the country [c] *)
val total_pop : t -> int

(** [healthy c] is the # of healthy people in the country [c] *)
val healthy : t -> int

(** [infected c] is the # of infected people in the country [c] *)
val infected : t -> int

(** [dead c] is the # of dead people in the country [c] *)
val dead : t -> int

(** [land_access c] returns a pair of the accessibility of outbound countries
    and a list of country ids accessible by land from [c] *)
val land_access : t -> int * country_id list

(** [sea_access c] returns the accessibility of other countries by sea 
    from [c] *)
val sea_access : t -> int

(** [air_access c] returns the accessibility of other countries by air
    from [c] *)
val air_access : t -> int

(** [close_border c b] is the resultant country representation type once the
    border variant (either [DRY], [SEA], or [AIR]) has been closed *)
val close_border : t -> border -> t

(** [infect c n] infects [n] number of people in country [c] from the virus *)
val infect : t -> int -> t

(** [recover c n] recovers [n] number of people in country [c] from the virus *)
val recover : t -> int -> t

(** [kill c n] kills [n] number of people in country [c] *)
val kill : t -> int -> t
