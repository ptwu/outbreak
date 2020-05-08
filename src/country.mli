(** [country_id] is the type representing the id used to access the country's
    information. *)
type country_id = string

(** [info] is the type containing immutable country information:
      [name]: the name of the country
      [temperature]: the average temperature of the country, which impacts the
        spread of the virus; 0 is neutral, negative is cold, positive is hot
      [health_care]: the amount of health care a country has, which impacts the
        spread of the virus
      [density]: the population density of the country, which impacts the spread
        of the virus
*)
type info = {
  name : string;
  temperature : int;
  health_care : int;
  density : int;
}

(** [border] is the type of a border between countries, which could be either
    DRY, SEA, or AIR. *)
type border = DRY | SEA | AIR

(** [population] is the type representing the population states of a country,
    containing information about the healthy, infected, and dead populations. *)
type population = { healthy : int; infected : int; dead : int }

(** [accessibility] is the type recording the degree to which each of a
    countries' borders allows for the spread of disease.
      [dry]: an association list of neighboring countries and their degrees of
        infectivity
      [sea]: a degree of infectivity to any other country in the world
      [air]: a degree of infectivity to any other country in the world
    Once countries close their borders, the degree of infectivity goes to 0. *)
type accessibility = { dry : float * country_id list; sea : float; air : float }

(** [t] is the type representing a country:
      [id]: the country's id
      [info]: the country's immutable information
      [population]: the country's record of healthy, infected, and dead
        populations
      [borders]: the country's record of degrees of infectivity with neighboring
        countries, by sea, and by air
*)
type t = {
  id : country_id;
  info : info;
  population : population;
  borders : accessibility;
}

(** [id c] is the id of a country [c]. *)
val id : t -> country_id

(** [name c] is the name of a country [c]. *)
val name : t -> string

(** [temperature c] is the temperature of a country [c]. *)
val temperature : t -> int

(** [health_care c] is the health care of a country [c]. *)
val health_care : t -> int

(** [density c] is the population density of a country [c]. *)
val density : t -> int

(** [total_pop c] is the total population of a country [c]. *)
val total_pop : t -> int

(** [healthy c] is the healthy population of a country [c]. *)
val healthy : t -> int

(** [infected c] is the infected population of a country [c]. *)
val infected : t -> int

(** [dead c] is the dead population of a country [c]. *)
val dead : t -> int

(** [land_access c] is an association list of neighboring countries and their
    degrees of infectivity of a country [c]. *)
val land_access : t -> float * country_id list

(** [sea_access c] is the degree of infectivity via sea of a country [c]. *)
val sea_access : t -> float

(** [air_access c] is the degree of infectivity via air of a country [c]. *)
val air_access : t -> float

(** [close_border c] shuts down a country [c]'s borders. *)
val close_border : t -> border -> t

(** [infect c] infects [n] people of a country [c]. *)
val infect : t -> int -> t

(** [recover c] cures [n] people of a country [c]*)
val recover : t -> int -> t

(** [kill c] kills [n] people of a country [c]*)
val kill : t -> int -> t
