type init_req = { name : string; starter : string; }

val init_req_from_json : Ezjsonm.value -> init_req

val json_of_info : Country.info -> Ezjsonm.t

val json_of_population : Country.population -> Ezjsonm.t

val json_of_stats : Stats.t -> Ezjsonm.t

val json_of_virus : Virus.t -> Ezjsonm.t

val json_of_country : Country.t -> Ezjsonm.t

val json_of_world : World.t -> Ezjsonm.t

val json_of_upgrade : Upgrades.upgrade -> Ezjsonm.t

val json_of_game : Engine.t -> Ezjsonm.t

val country_from_json : Ezjsonm.value -> Country.t

val world_from_json : Ezjsonm.value -> World.t

val stats_from_json : Ezjsonm.value -> Stats.t

val upgrade_from_json : Ezjsonm.value -> Upgrades.upgrade

val shop_from_json : Ezjsonm.value -> Upgrades.t