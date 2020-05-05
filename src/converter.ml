open Ezjsonm

let json_of_info ({ name; temperature; health_care; density } : Country.info) = 
  dict [
    "name", string name;
    "temperature", int temperature;
    "health_care", int health_care;
    "density", int density;
  ]

let json_of_population ({ healthy; infected; dead } : Country.population) = 
  dict [
    "healthy", int healthy;
    "infected", int infected;
    "dead", int dead;
  ]

let json_of_stats ({ infectivity; severity; hality; heat_res; cold_res; drug_res; anti_cure } : Stats.t) = 
  dict [
    "infectivity", int infectivity;
    "severity", int severity;
    "hality", int hality;
    "heat_res", int heat_res;
    "cold_res", int cold_res;
    "drug_res", int drug_res;
    "anti_cure", int anti_cure;
  ]

let json_of_virus ({ name; stats; upgrades; points } : Virus.t) =
  dict [
    "name", string name;
    "stats", json_of_stats stats;
    "upgrades", list string upgrades;
    "points", int points;
  ]

let json_of_country ({ id; info; population; borders } : Country.t) =
  dict [
    "id", string id;
    "info", json_of_info info;
    "population", json_of_population population;
  ]

let json_of_world ({ countries; cure_progress; cure_rate } as world : World.t) =
  dict [
    "countries", list json_of_country countries;
    "population", json_of_population (World.world_pop world);
    "cure_progress", float cure_progress;
    "cure_rate", float cure_rate;
  ]

let json_of_upgrade ({ id; name; offsets; cost } : Upgrades.upgrade) =
  dict [
    "id", string id;
    "name", string name;
    "offsets", json_of_stats offsets;
    "cost", int cost;
  ]

let json_of_game ({ virus; world; shop } : Engine.t) =
  dict [
    "virus", json_of_virus virus;
    "world", json_of_world world;
    "shop", list json_of_upgrade shop
  ]