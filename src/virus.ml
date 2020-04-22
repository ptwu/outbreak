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