type t = {
  infectivity : int;
  severity : int;
  lethality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
}

let init_virus =
  {
    infectivity = 1;
    severity = 1;
    lethality = 1;
    heat_res = 0;
    cold_res = 0;
    drug_res = 0;
    anti_cure = 0;
  }

(** [empty_upgrade] represents an virus upgrade with empty stats. *)
let empty_upgrade =
  {
    infectivity = 0;
    severity = 0;
    lethality = 0;
    heat_res = 0;
    cold_res = 0;
    drug_res = 0;
    anti_cure = 0;
  }

let get_infectivity v = v.infectivity

let get_severity v = v.severity

let get_lethality v = v.lethality

let get_heat_res v = v.heat_res

let get_cold_res v = v.cold_res

let get_drug_res v = v.drug_res

let get_anti_cure v = v.anti_cure

(** [upgrade upg_offsets v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
let upgrade (upg_offsets : t) (v : t) : t =
  {
    infectivity = v.infectivity + upg_offsets.infectivity;
    severity = v.severity + upg_offsets.severity;
    lethality = v.lethality + upg_offsets.lethality;
    heat_res = v.heat_res + upg_offsets.heat_res;
    cold_res = v.cold_res + upg_offsets.cold_res;
    drug_res = v.drug_res + upg_offsets.drug_res;
    anti_cure = v.anti_cure + upg_offsets.anti_cure;
  }
