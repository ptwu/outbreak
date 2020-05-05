val json_of_info : Country.info -> [> Ezjsonm.t ]

val json_of_population : Country.population -> [> Ezjsonm.t ]

val json_of_stats : Stats.t -> [> Ezjsonm.t ]

val json_of_virus : Virus.t -> [> Ezjsonm.t ]

val json_of_country : Country.t -> [> Ezjsonm.t ]

val json_of_world : World.t -> [> Ezjsonm.t ]

val json_of_upgrade : Upgrades.upgrade -> [> Ezjsonm.t ]

val json_of_game : Engine.t -> [> Ezjsonm.t ]
