open Stats
open Upgrades

type t = {
  name : string;
  stats : Stats.t;
  upgrades : string list;
  points : int;
}

let init_virus =
  {
    name = "Corona";
    stats =
      {
        infectivity = 0.000001;
        severity = 0.;
        hality = 0.;
        heat_res = 0.;
        cold_res = 0.;
        drug_res = 0.;
        anti_cure = 0.;
      };
    upgrades = [];
    points = 0;
  }

let infectivity v = v.stats.infectivity

let severity v = v.stats.severity

let hality v = v.stats.hality

let heat_res v = v.stats.heat_res

let cold_res v = v.stats.cold_res

let drug_res v = v.stats.drug_res

let anti_cure v = v.stats.anti_cure

let get_drug v = v.drug_res

let add_points p v = { v with points = v.points + p }

let upgrade (v : t) (u : upgrade) : t =
  if v.points >= u.cost then
    let us, vs = (u.offsets, v.stats) in
    {
      v with
      stats =
        {
          infectivity = vs.infectivity +. us.infectivity;
          severity = vs.severity +. us.severity;
          hality = vs.hality +. us.hality;
          heat_res = vs.heat_res +. us.heat_res;
          cold_res = vs.cold_res +. us.cold_res;
          drug_res = vs.drug_res +. us.drug_res;
          anti_cure = vs.anti_cure +. us.anti_cure;
        };
      upgrades = u.id :: v.upgrades;
      points = v.points - u.cost;
    }
  else v

let change_name (n : string) (v : t) : t =
  if (n <> "") then {v with name = n}
  else v