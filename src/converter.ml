open Ezjsonm

type init_req =
  {
    name : string;
    starter : string;
  }

let init_req_from_json json =
  {
    name = ["name"] |> find json |> get_string;
    starter = ["starter"] |> find json |> get_string;
  }

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
    "infectivity", float infectivity;
    "severity", float severity;
    "hality", float hality;
    "heat_res", float heat_res;
    "cold_res", float cold_res;
    "drug_res", float drug_res;
    "anti_cure", float anti_cure;
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

let json_of_shop (shop : Upgrades.t) = list json_of_upgrade shop

let json_of_game ({ virus; world; shop; status } : Engine.t) =
  dict [
    "virus", json_of_virus virus;
    "world", json_of_world world;
    "shop", json_of_shop shop;
    "score", match status with
    | Init | Playing -> float 0.0
    | Done (_, s) -> float s
  ]

let country_from_json json : Country.t =
  {
    id = ["id"] |> find json |> get_string;
    info = {
      name = ["info"; "name"] |> find json |> get_string;
      temperature = ["info"; "temperature"] |> find json |> get_int;
      health_care = ["info"; "health_care"] |> find json |> get_int;
      density = ["info"; "density"] |> find json |> get_int;
    };
    population = {
      healthy = ["population"] |> find json |> get_int;
      infected = 0;
      dead = 0;
    };
    borders = {
      dry = ["borders"; "dry"] |> find json |> get_pair get_float (get_list get_string);
      sea = ["borders"; "sea"] |> find json |> get_float;
      air = ["borders"; "air"] |> find json |> get_float;
    };
  }

let world_from_json json : World.t =
  {
    countries = ["countries"] |> find json |> get_list country_from_json;
    cure_progress = ["cure_progress"] |> find json |> get_float;
    cure_rate = ["cure_rate"] |> find json |> get_float;
  }

let stats_from_json json : Stats.t =
  {
    infectivity = ["infectivity"] |> find json |> get_float;
    severity = ["severity"] |> find json |> get_float;
    hality = ["hality"] |> find json |> get_float;
    heat_res = ["heat_res"] |> find json |> get_float;
    cold_res = ["cold_res"] |> find json |> get_float;
    drug_res = ["drug_res"] |> find json |> get_float;
    anti_cure = ["anti_cure"] |> find json |> get_float;
  }

let upgrade_from_json json : Upgrades.upgrade =
  {
    id = ["id"] |> find json |> get_string;
    name = ["name"] |> find json |> get_string;
    offsets = ["offsets"] |> find json |> stats_from_json;
    cost = ["cost"] |> find json |> get_int;
  }

let shop_from_json json : Upgrades.t = get_list upgrade_from_json json

let game_from_json json : Engine.t =
  {
    virus = Virus.init_virus;
    world = ["world"] |> find json |> world_from_json;
    shop = ["shop"] |> find json |> shop_from_json;
    status = Init;
  }