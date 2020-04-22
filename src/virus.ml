type t = {
  infectivity : int;
  severity : int;
  lethality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
}

let init_virus = {
  infectivity = 1;
  severity = 1;
  lethality = 1;
  heat_res = 0;
  cold_res = 0;
  drug_res = 0;
}

(** [empty_upgrade] represents an virus upgrade with empty stats. *)
let empty_upgrade = {
  infectivity = 0;
  severity = 0;
  lethality = 0;
  heat_res = 0;
  cold_res = 0;
  drug_res = 0;
}

let get_infect v =
  v.infectivity

let get_sever v =
  v.severity

let get_lethal v =
  v.lethality

let get_heat v =
  v.heat_res

let get_cold v =
  v.cold_res

let get_drug v =
  v.drug_res

(** [upgrade upg_offsets v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
let upgrade (upg_offsets : t) (v : t) : t  = match upg_offsets with
  | { infectivity = inf; severity = sev; lethality = le; heat_res = hr;
      cold_res = cr; drug_res = dr } -> 
    {
      infectivity = get_infect v + inf;
      severity = get_sever v + sev;
      lethality = get_lethal v + le;
      heat_res = get_heat v + hr;
      cold_res = get_cold v + cr;
      drug_res = get_drug v + dr
    }