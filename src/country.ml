type country_id = string

(** immutable info
    note for temperature: 0 is "neutral", negative is cold, positive is hot *)
type info = {
  name : string;
  temperature : int;
  health_care : int;
  density : int;
}

type border = DRY | SEA | AIR

type population = { healthy : int; infected : int; dead : int }

(** Closed borders = 0 *)
type accessibility = { dry : float * country_id list; sea : float; air : float }

(** "Main" mutable type representing a country *)
type t = {
  id : country_id;
  info : info;
  population : population;
  borders : accessibility;
}

let id c = c.id

let name c = c.info.name

let temperature c = c.info.temperature

let health_care c = c.info.health_care

let density c = c.info.density

let total_pop c =
  c.population.healthy + c.population.infected + c.population.dead

let healthy c = c.population.healthy

let infected c = c.population.infected

let dead c = c.population.dead

let land_access c = c.borders.dry

let sea_access c = c.borders.sea

let air_access c = c.borders.air

let close_border c b =
  {
    c with
    borders =
      ( match b with
        | DRY -> { c.borders with dry = (0., []) }
        | SEA -> { c.borders with sea = 0. }
        | AIR -> { c.borders with air = 0. } );
  }

let infect c n =
  let n' = min n c.population.healthy in
  {
    c with
    population =
      {
        c.population with
        healthy = c.population.healthy - n';
        infected = c.population.infected + n';
      };
  }

(* Right now this is basically [infect] but reversed.
   We might want to change it later tho *)
let recover c n =
  let n' = min n c.population.infected in
  {
    c with
    population =
      {
        c.population with
        healthy = c.population.healthy + n';
        infected = c.population.infected - n';
      };
  }

let kill c n =
  let n' = min n c.population.infected in
  {
    c with
    population =
      {
        c.population with
        infected = c.population.infected - n';
        dead = c.population.dead + n';
      };
  }
