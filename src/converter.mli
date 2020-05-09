(** [init_req] is the type of a 'init' request body. *)
type init_req = { name : string; starter : string; }

(** [init_req_from_json json] is [json] parsed into type [init_req]. *)
val init_req_from_json : Ezjsonm.value -> init_req

(** [json_of_info o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_info : Country.info -> Ezjsonm.t

(** [json_of_population o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_population : Country.population -> Ezjsonm.t

(** [json_of_stats o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_stats : Stats.t -> Ezjsonm.t

(** [json_of_virus o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_virus : Virus.t -> Ezjsonm.t

(** [json_of_country o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_country : Country.t -> Ezjsonm.t

(** [json_of_world o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_world : World.t -> Ezjsonm.t

(** [json_of_upgrade o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_upgrade : Upgrades.upgrade -> Ezjsonm.t

(** [json_of_game o] is [o] parsed into type [Ezjsonm.t]. *)
val json_of_game : Engine.t -> Ezjsonm.t

(** [country_from_json json] is [json] parsed into type [Country.t]. *)
val country_from_json : Ezjsonm.value -> Country.t

(** [world_from_json json] is [json] parsed into type [World.t]. *)
val world_from_json : Ezjsonm.value -> World.t

(** [stats_from_json json] is [json] parsed into type [Stats.t]. *)
val stats_from_json : Ezjsonm.value -> Stats.t

(** [upgrade_from_json json] is [json] parsed into type [Upgrades.upgrade]. *)
val upgrade_from_json : Ezjsonm.value -> Upgrades.upgrade

(** [shop_from_json json] is [json] parsed into type [Upgrades.t]. *)
val shop_from_json : Ezjsonm.value -> Upgrades.t

(** [game_from_json json] is [json] parsed into type [Engine.t]. *)
val game_from_json : Ezjsonm.value -> Engine.t