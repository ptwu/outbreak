(** The representation type for the stats of a virus. *)
type t = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
}