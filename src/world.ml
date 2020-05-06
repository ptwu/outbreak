open Country
open Yojson.Basic.Util

type t = {
  countries: Country.t list;
  cure_progress: float;
  cure_rate: float;
}

let init_world = {
  countries = [{
      id = "greenland";
      info =
        {
          name = "Greenland";
          temperature = -100;
          health_care = 50;
          density = 10;
        };
      population = { healthy = 300000; infected = 0; dead = 0 };
      borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
    }];
  cure_progress = 0.0;
  cure_rate = 0.001;
}

let country_from_json json =
  let cid = json |> member "country id" |> to_string in
  let infohelp json =
    let cname = json |> member "country name" |> to_string in
    let ctemp = json |> member "temperature" |> to_int in
    let chealth = json |> member "healthcare" |> to_int in
    let cdens = json |> member "density" |> to_int in
    {name=cname; temperature=ctemp; health_care=chealth; density=cdens} in
  let cinfo = json |> member "info" |> infohelp in
  let pophelp json =
    let ch = json |> member "healthy" |> to_int in
    let ci = json |> member "infected" |> to_int in
    let cd = json |> member "dead" |> to_int in
    {healthy=ch; infected=ci; dead=cd} in
  let cpop = json |> member "population" |> pophelp in
  let bordhelp json =
    let dryhelp json =
      let num = json |> index 0 |> to_int in
      let bord = json |> index 1 |> to_list |> filter_string in
      (num, bord)  in
    let cdry = json |> member "dry" |> dryhelp in
    let csea = json |> member "sea" |> to_int in
    let cair = json |> member "air" |> to_int in
    {dry=cdry; sea=csea; air=cair} in
  let cbord = json |> member "borders" |> bordhelp in
  {id=cid; info=cinfo; population=cpop; borders=cbord}

let world_from_json json =
  let wcount = json |> member "countries" |> to_list |> List.map country_from_json in
  let wcureprog = json |> member "cure progress" |> to_float in
  let wcurerate = json |> member "cure rate" |> to_float in
  {countries=wcount; cure_progress=wcureprog; cure_rate=wcurerate}

let world_total_pop w = 
  w.countries |> List.map total_pop |> List.fold_left (+) 0 

let world_healthy_pop w =
  w.countries |> List.map healthy |> List.fold_left (+) 0 

let world_infected_pop w =
  w.countries |> List.map infected |> List.fold_left (+) 0 

let world_dead_pop w =
  w.countries |> List.map dead |> List.fold_left (+) 0

let world_pop w = {
  healthy = world_healthy_pop w;
  infected = world_infected_pop w;
  dead = world_dead_pop w;
}

let score w =
  float (world_infected_pop w + (2 * world_dead_pop w)) -. cure_progress w