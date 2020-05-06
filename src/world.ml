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


(* Note: current max threshotd for cur  progress is hardcoded 100 *)
let world_pop world = 
  world.countries |> List.map total_pop |> List.fold_left (+) 0 

let world_healthy_pop world =
  world.countries |> List.map healthy |> List.fold_left (+) 0 

let world_infected_pop world =
  world.countries |> List.map infected |> List.fold_left (+) 0 

let world_dead_pop world =
  world.countries |> List.map dead |> List.fold_left (+) 0

let cure_progress world =
  world.cure_progress

let score w =
  float (world_infected_pop w + (2 * world_dead_pop w)) -. cure_progress w