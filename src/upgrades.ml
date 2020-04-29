open Stats

type upgrade = { id : string; name : string; offsets : Stats.t; cost : int }

type t = upgrade list

let init_upgrades =
  [
    {
      id = "cough";
      name = "Symptom: Coughing";
      offsets =
        {
          infectivity = 2;
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
      id = "organfailure";
      name = "Symptom: Organ Failure";
      offsets =
        {
          infectivity = 0;
          severity = 50;
          hality = 15;
          heat_res = 0;
          cold_res = 0;
          drug_res = 0;
          anti_cure = 0;
        };
      cost = 10;
    };
  ]