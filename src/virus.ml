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

let getinfect v =
  v.infectivity

let getsever v =
  v.severity

let getlethal v =
  v.lethality

let getheat v =
  v.heat_res

let getcold v =
  v.cold_res

let getdrug v =
  v.drug_res

let upgrade upg_type upg_val v =
  match upg_type with
  | "infectivity" -> {infectivity = (getinfect v)+(upg_val);
                      severity = (getsever v); lethality = (getlethal v);
                      heat_res = (getheat v); cold_res = (getcold v);
                      drug_res = (getdrug v)}
  | "severity" -> {infectivity = (getinfect v); 
                   severity = (getsever v)+(upg_val); lethality = (getlethal v);
                   heat_res = (getheat v); cold_res = (getcold v);
                   drug_res = (getdrug v)}
  | "lethality" -> {infectivity = (getinfect v); severity = (getsever v);
                    lethality = (getlethal v)+(upg_val); heat_res = (getheat v);
                    cold_res = (getcold v); drug_res = (getdrug v)}
  | "heat_res" -> {infectivity = (getinfect v); severity = (getsever v);
                   lethality = (getlethal v); heat_res = (getheat v)+(upg_val);
                   cold_res = (getcold v); drug_res = (getdrug v)}
  | "cold_res" -> {infectivity = (getinfect v); severity = (getsever v);
                   lethality = (getlethal v); heat_res = (getheat v);
                   cold_res = (getcold v)+(upg_val); drug_res = (getdrug v)}
  | "drug_res" -> {infectivity = (getinfect v); severity = (getsever v);
                   lethality = (getlethal v); heat_res = (getheat v);
                   cold_res = (getcold v); drug_res = (getdrug v)+(upg_val)}
  | _ -> failwith "Invalid Upgrade"