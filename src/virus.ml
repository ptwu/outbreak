type stats = {
  infectivity : int;
  severity : int;
  hality : int;
  heat_res : int;
  cold_res : int;
  drug_res : int;
  anti_cure : int;
}

type upgrade = { id : string; name : string; stats : stats; cost : int }

type t = {
  name : string;
  stats : stats;
  upgrades : string list;
  points : int;
}

let init_virus =
  {
    name = "Corona";
    stats =
      {
        infectivity = 1;
        severity = 0;
        hality = 0;
        heat_res = 0;
        cold_res = 0;
        drug_res = 0;
        anti_cure = 0;
      };
    upgrades = [];
    points = 0;
  }

let init_upgrades =
  [
    {
      id = "cough";
      name = "Symptom: Coughing";
      stats =
        {
          infectivity = 15;
          severity = 0;
          hality = 0;
          heat_res = 0;
          cold_res = 0;
          drug_res = 0;
          anti_cure = 0;
        };
      cost = 1;
    };
    {
      id = "internalbleeding";
      name = "Symptom: Internal Bleeding";
      stats =
        {
          infectivity = 0;
          severity = 50;
          hality = 50;
          heat_res = 0;
          cold_res = 0;
          drug_res = 0;
          anti_cure = 0;
        };
      cost = 10;
    };
  ]

let infectivity v = v.stats.infectivity

let severity v = v.stats.severity

let hality v = v.stats.hality

let heat_res v = v.stats.heat_res

let cold_res v = v.stats.cold_res

let drug_res v = v.stats.drug_res

let anti_cure v = v.stats.anti_cure

let get_drug v = v.drug_res

let add_points p v = { v with points = v.points + p }

(** [upgrade u v] is an upgraded virus representing the new stats
    of a virus if it takes a record of attribute offsets containing offset
    values of certain stats *)
let upgrade (u : upgrade) (v : t) : t =
  let us, vs = (u.stats, v.stats) in
  {
    v with
    stats =
      {
        infectivity = vs.infectivity + us.infectivity;
        severity = vs.severity + us.severity;
        hality = vs.hality + us.hality;
        heat_res = vs.heat_res + us.heat_res;
        cold_res = vs.cold_res + us.cold_res;
        drug_res = vs.drug_res + us.drug_res;
        anti_cure = vs.anti_cure + us.anti_cure;
      };
    upgrades = u.id :: v.upgrades;
    points = v.points - u.cost;
  }
