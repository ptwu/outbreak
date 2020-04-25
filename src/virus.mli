(** The representation type for a virus. *)
type t = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
}

val init_virus : t

val empty_upgrade : t

val infectivity : t -> int

val severity : t -> int

val hality : t -> int

val heat_res : t -> int

val cold_res : t -> int
<<<<<<< HEAD

val drug_res : t -> int
=======
>>>>>>> 2b0796d786869ec2e95da92dfeaf3dbe2c4dd9da

val drug_res : t -> int

val upgrade : t -> t -> t
