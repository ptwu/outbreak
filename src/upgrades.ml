open Stats

type upgrade = { id : string; name : string; offsets : Stats.t; cost : int }

type t = upgrade list
