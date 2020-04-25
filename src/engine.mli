type t = {
  virus : Virus.t;
  world : World.t
}

val init_state : t

val step : t -> t
