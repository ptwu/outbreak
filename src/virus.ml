type t = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
  upgrades : string list;
}

type upgrade = t

let init_virus =
  {
    infectivity = 1;
    severity = 1;
    hality = 1;
    heat_res = 0;
    cold_res = 0;
    drug_res = 0;
    anti_cure = 0;
    upgrades = [];
  }

let empty_upgrade : upgrade =
  {
    infectivity = 0;
    severity = 0;
    hality = 0;
    heat_res = 0;
    cold_res = 0;
    drug_res = 0;
    anti_cure = 0;
    upgrades = ["empty upgrade"]
  }

let infectivity v = v.infectivity

let severity v = v.severity

let hality v = v.hality

let heat_res v = v.heat_res

let cold_res v = v.cold_res

let drug_res v = v.drug_res

let anti_cure v = v.anti_cure

let upgrades v = v.upgrades

(** [upgrade upg_offsets v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
let upgrade (upg_name : string) (u : upgrade) (v : t) : t =
  {
    infectivity = v.infectivity + u.infectivity;
    severity = v.severity + u.severity;
    hality = v.hality + u.hality;
    heat_res = v.heat_res + u.heat_res;
    cold_res = v.cold_res + u.cold_res;
    drug_res = v.drug_res + u.drug_res;
    anti_cure = v.anti_cure + u.anti_cure;
    upgrades = upg_name :: v.upgrades
  }
