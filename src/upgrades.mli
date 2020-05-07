(** The representation type for a virus upgrade. *)
type upgrade = { id : string; name : string; offsets : Stats.t; cost : int }

(** The representation type for a list of virus upgrades. *)
type t = upgrade list
