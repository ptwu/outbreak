(** [t] is a virus *)
type t

(** [init_virus] is the state of a virus at the start of the game *)
val init_virus : t

(** [empty_upgrade] is a virus upgrade with empty stats *)
val empty_upgrade : t

(** [get_infect] is a function that returns the infectivity of a virus [t] *)
val get_infect : t -> int

(** [get_sever] is a function that returns the severity of a virus [t] *)
val get_sever : t -> int

(** [get_lethal] is a function that returns the lethality of a virus [t] *)
val get_lethal : t -> int

(** [get_heat] is a function that returns the heat resistance of a virus [t] *)
val get_heat : t -> int

(** [get_cold] is a function that returns the cold resistance of a virus [t] *)
val get_cold : t -> int

(** [get_drug] is a function that returns the drug resistance of a virus [t] *)
val upgrade : t -> t -> t