(** TESTING PLAN:

    Our test suite started off testing functions individually with "dummy" 
    virus, world, and upgrade values. Once we had our json parser and basic
    functionality, we moved on from a glass box testing approach to a more black
    box testing approach, where we used world, virus, and upgrade values with
    more abstract functions that would be directly used on them during the game.
    In addition, much of our testing later in development was through
    playtesting, especially for the functionality of server.ml, engine.ml, and
    the webapp.

    Modules tested by OUnit:
      country.ml
      virus.ml
      world.ml
      stats.ml
      upgrades.ml

    Modules playtested:
      engine.ml
      server.ml
      converter.ml

    This plan demonstrates the correctness of the system by ensuring the
    correctness of individual functions of the program on a small scale as well
    as testing certain modules in the context in which they will be used. This
    allows for smaller issues to be discovered with more precision and fixed
    more quickly, and for larger ones to be viewed in the context of gameplay
    itself.
*)

open OUnit2
open Virus
open Country
open World
open Upgrades
open Converter

(** [make_virus_upgrade_test name offsets init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [upgrade offsets init]. *)
let make_virus_upgrade_test
    (name : string) 
    (offsets: Upgrades.upgrade)
    (init: Virus.t) 
    (expected_output : Virus.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (upgrade init offsets))

(** [make_add_points_test name points init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [add_points points init]. *)
let make_add_points_test
    (name : string) 
    (points: int)
    (init: Virus.t) 
    (expected_output : Virus.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (add_points points init))

(** [make_change_name_test name n v expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [change_name n v]. *)
let make_change_name_test
    (name : string) 
    (n: string)
    (v: Virus.t) 
    (expected_output : Virus.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (change_name n v))

(** [make_cure_progress_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [cure_progress init]. *)
let make_cure_progress_test
    (name : string)
    (init: World.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (World.cure_progress init))

(** [make_cure_rate_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [cure_rate init]. *)
let make_cure_rate_test
    (name : string)
    (init: World.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (World.cure_rate init))

(** [make_world_total_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [world_total_pop init]. *)
let make_world_total_pop_test
    (name : string)
    (init: World.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (world_total_pop init))

(** [make_world_healthy_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [world_healthy_pop init]. *)
let make_world_healthy_pop_test
    (name : string)
    (init: World.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (world_healthy_pop init))

(** [make_world_infected_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [world_infected_pop init]. *)
let make_world_infected_pop_test
    (name : string)
    (init: World.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (world_infected_pop init))

(** [make_world_dead_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [world_dead_pop init]. *)
let make_world_dead_pop_test
    (name : string)
    (init: World.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (world_dead_pop init))

(** [make_score_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [score init]. *)
let make_score_test
    (name : string)
    (init: World.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (World.score init))

(** [make_country_id_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [id init]. *)
let make_country_id_test
    (name : string)
    (init: Country.t) 
    (expected_output : Country.country_id) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (id init))

(** [make_country_name_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [name init]. *)
let make_country_name_test
    (name : string)
    (init: Country.t) 
    (expected_output : string) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (Country.name init))

(** [make_temperature_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [temperature init]. *)
let make_temperature_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (temperature init))

(** [make_health_care_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [health_care init]. *)
let make_health_care_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (health_care init))

(** [make_density_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [density init]. *)
let make_density_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (density init))

(** [make_country_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [total_pop init]. *)
let make_country_pop_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (total_pop init))

(** [make_country_healthy_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [healthy init]. *)
let make_country_healthy_pop_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (healthy init))

(** [make_country_infected_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [infected init]. *)
let make_country_infected_pop_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (infected init))

(** [make_country_dead_pop_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [dead init]. *)
let make_country_dead_pop_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (dead init))

(** [make_land_access_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [land_access init]. *)
let make_land_access_test
    (name : string)
    (init: Country.t) 
    (expected_output : float * country_id list) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (land_access init))

(** [make_sea_access_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [sea_access init]. *)
let make_sea_access_test
    (name : string)
    (init: Country.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (sea_access init))

(** [make_air_access_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [air_access init]. *)
let make_air_access_test
    (name : string)
    (init: Country.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (air_access init))

(** [make_close_border_test name init b expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [close_border init b]. *)
let make_close_border_test
    (name : string)
    (init: Country.t)
    (b : Country.border)
    (expected_output : Country.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (close_border init b))

(** [make_infect_test name init n expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [infect init n]. *)
let make_infect_test
    (name : string)
    (init: Country.t)
    (n : int)
    (expected_output : Country.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (infect init n))

(** [make_recover_test name init n expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [recover init n]. *)
let make_recover_test
    (name : string)
    (init: Country.t)
    (n : int)
    (expected_output : Country.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (recover init n))

(** [make_kill_test name init n expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [kill init n]. *)
let make_kill_test
    (name : string)
    (init: Country.t)
    (n : int)
    (expected_output : Country.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (kill init n))

(** [make_infect_country_test name c n w expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [infect_country c n w]. *)
let make_infect_country_test
    (name : string)
    (c: Country.country_id)
    (n : int)
    (w : World.t)
    (expected_output : World.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (infect_country c n w))

let dummy_virus0 =  
  {
    name = "Corona";
    stats =
      {
        infectivity = 1.;
        severity = 0.;
        hality = 0.;
        heat_res = 0.;
        cold_res = 0.;
        drug_res = 0.;
        anti_cure = 0.;
      };
    upgrades = [];
    points = 0;
  }

let dummy_virus1 = {
  dummy_virus0 with
  name = "Influenza"
}

let dummy_virus = {
  dummy_virus0 with
  points = 3
}

let dummy_upgrade = {
  id = "test_upgrade";
  name = "test";
  offsets =
    {
      infectivity = 2.;
      severity = 1.;
      hality = 10.;
      heat_res = 1.;
      cold_res = 2.;
      drug_res = 4.;
      anti_cure = 6.;
    };
  cost = 2;
}

let bad_upgrade = {
  dummy_upgrade with 
  cost = 100
}

let expected_upgraded_virus = {
  dummy_virus with
  stats={
    infectivity = 3.;
    severity = 1.;
    hality = 10.;
    heat_res = 1.;
    cold_res = 2.;
    drug_res = 4.;
    anti_cure = 6.;
  };
  upgrades=["test_upgrade"];
  points=1;
}

let dummy_country =
  {
    id = "greenland";
    info =
      {
        name = "Greenland";
        temperature = -100;
        health_care = 50;
        density = 10;
      };
    population = { healthy = 300000; infected = 0; dead = 0 };
    borders = { dry = (50., [ "us" ]); sea = 50.; air = 50. };
  }

let dummy_country2 = {
  dummy_country with
  population = { healthy = 299900; infected = 100; dead = 0 }
}

let dummy_country3 = {
  dummy_country with
  population = { healthy = 0; infected = 300000; dead = 0 }
}

let dummy_land_expected_country = {
  dummy_country with
  borders = { dry = (0., []); sea = 50.; air = 50. }
}

let dummy_sea_expected_country = {
  dummy_country with
  borders = { dry = (50., [ "us" ]); sea = 0.; air = 50. }
}

let dummy_air_expected_country = {
  dummy_country with
  borders = { dry = (50., [ "us" ]); sea = 50.; air = 0. }
}

let dummy_infect_expected_country = {
  dummy_country with
  population = { healthy = 200000; infected = 100000; dead = 0 }
}

let dummy_infect_expected_country2 = {
  dummy_country with
  population = { healthy = 0; infected = 300000; dead = 0 }
}

let dummy_recover_expected_country = {
  dummy_country with
  population = { healthy = 250000; infected = 50000; dead = 0 }
}

let dummy_kill_expected_country = {
  dummy_country with
  population = { healthy = 250000; infected = 25000; dead = 25000 }
}

let dummy_kill_expected_country2 = {
  dummy_country with
  population = { healthy = 250000; infected = 0; dead = 50000 }
}

let w = {
  countries = [dummy_country];
  cure_progress = 0.0;
  cure_rate = 0.01
}

let w2 = {
  w with 
  countries = [dummy_country2]
}

let w3 = {
  w with 
  countries = [dummy_country3]
}

let virus_tests = [
  make_virus_upgrade_test "testing basic upgrade with dummy virus" 
    dummy_upgrade dummy_virus expected_upgraded_virus;
  make_virus_upgrade_test "testing too expensive upgrade with dummy virus" 
    bad_upgrade dummy_virus dummy_virus;
  make_add_points_test "testing adding points with dummy virus"
    3 dummy_virus0 dummy_virus;
  make_change_name_test "testing changing virus name"
    "Influenza" dummy_virus0 dummy_virus1;
  make_change_name_test "testing invalid virus name"
    "" dummy_virus0 dummy_virus0
]

let country_tests = [
  make_country_id_test "testing country id with dummy country" 
    dummy_country "greenland";
  make_country_name_test "testing country name with dummy country"
    dummy_country "Greenland";
  make_temperature_test "testing temperature with dummy country"
    dummy_country (-100);
  make_health_care_test "testing health care with dummy country"
    dummy_country 50;
  make_density_test "testing density with dummy country"
    dummy_country 10;
  make_country_pop_test "testing total country population with dummy country"
    dummy_country 300000;
  make_country_healthy_pop_test "testing healthy country pop with dummy country"
    dummy_country 300000;
  make_country_infected_pop_test "testing infect country pop with dummy country"
    dummy_country 0;
  make_country_dead_pop_test "testing country dead pop with dummy country"
    dummy_country 0;
  make_land_access_test "testing land access with dummy country"
    dummy_country (50., ["us"]);
  make_sea_access_test "testing sea access with dummy country"
    dummy_country 50.;
  make_air_access_test "testing air access with dummy country"
    dummy_country 50.;
  make_close_border_test "testing closing land border with dummy country"
    dummy_country DRY dummy_land_expected_country;
  make_close_border_test "testing closing sea border with dummy country"
    dummy_country SEA dummy_sea_expected_country;
  make_close_border_test "testing closing air border with dummy country"
    dummy_country AIR dummy_air_expected_country;
  make_infect_test "testing country infection with dummy country"
    dummy_country 100000 dummy_infect_expected_country;
  make_infect_test "testing too much country infection with dummy country"
    dummy_country 1000000 dummy_infect_expected_country2;
  make_infect_test "testing no country infection with dummy country"
    dummy_country 0 dummy_country;
  make_recover_test "testing country recovery with dummy country"
    dummy_infect_expected_country 50000 dummy_recover_expected_country;
  make_recover_test "testing too much country recovery with dummy country"
    dummy_infect_expected_country 1000000 dummy_country;
  make_recover_test "testing no country recovery with dummy country"
    dummy_infect_expected_country 0 dummy_infect_expected_country;
  make_kill_test "testing country death with dummy country"
    dummy_recover_expected_country 25000 dummy_kill_expected_country;
  make_kill_test "testing too much country death with dummy country"
    dummy_recover_expected_country 1000000 dummy_kill_expected_country2;
  make_kill_test "testing no country death with dummy country"
    dummy_recover_expected_country 0 dummy_recover_expected_country;
]


let world_tests = [
  make_cure_progress_test "testing cure progress in world" 
    w 0.0;
  make_cure_rate_test "testing cure rate in world" 
    w 0.01;
  make_world_total_pop_test "testing world population in world" 
    w 300000;
  make_world_healthy_pop_test "testing world healthy population in world"
    w 300000;
  make_world_infected_pop_test "testing world infected population in world"
    w 0;
  make_world_dead_pop_test "testing world dead population in world"
    w 0;
  make_score_test "testing player score in world"
    w 0.0;
  make_infect_country_test "testing infecting country"
    "greenland" 100 w w2;
  make_infect_country_test "testing infecting no one in country"
    "greenland" 0 w w;
  make_infect_country_test "testing infecting too many in country"
    "greenland" 1000000 w w3;
  make_score_test "testing changing player score in world"
    w3 300000.;
]

let suite = "outbreak tests suite" >::: List.flatten [
    virus_tests;
    world_tests;
    country_tests
  ]

let _ = run_test_tt_main suite