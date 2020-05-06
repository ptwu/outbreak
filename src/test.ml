open OUnit2
open Virus
open Country
open World
open Upgrades

(** [make_virus_upgrade_test name offsets init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [upgrade offsets init]. *)
let make_virus_upgrade_test
    (name : string) 
    (offsets: upgrade)
    (init: Virus.t) 
    (expected_output : Virus.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (upgrade init offsets))

(** [make_cure_progress_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [cure_progress init]. *)
let make_cure_progress_test
    (name : string)
    (init: World.t) 
    (expected_output : float) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (World.cure_progress init))

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
    (expected_output : int * country_id list) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (land_access init))

(** [make_sea_access_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [sea_access init]. *)
let make_sea_access_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (sea_access init))

(** [make_air_access_test name init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [air_access init]. *)
let make_air_access_test
    (name : string)
    (init: Country.t) 
    (expected_output : int) : test = 
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

let dummy_upgrade = {
  id = "test_upgrade";
  name = "test";
  offsets =
    {
      infectivity = 2;
      severity = 1;
      hality = 10;
      heat_res = 1;
      cold_res = 2;
      drug_res = 4;
      anti_cure = 6;
    };
  cost = 2;
}

let expected_upgraded_virus =  
  {
    name = "Corona";
    stats =
      {
        infectivity = 3;
        severity = 1;
        hality = 10;
        heat_res = 1;
        cold_res = 2;
        drug_res = 4;
        anti_cure = 6;
      };
    upgrades = ["test_upgrade"];
    points = 1;
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
    borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
  }

let dummy_land_expected_country =
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
    borders = { dry = (0, []); sea = 50; air = 50 };
  }

let dummy_sea_expected_country =
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
    borders = { dry = (50, [ "us" ]); sea = 0; air = 50 };
  }

let dummy_air_expected_country =
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
    borders = { dry = (50, [ "us" ]); sea = 50; air = 0 };
  }

let dummy_infect_expected_country =
  {
    id = "greenland";
    info =
      {
        name = "Greenland";
        temperature = -100;
        health_care = 50;
        density = 10;
      };
    population = { healthy = 200000; infected = 100000; dead = 0 };
    borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
  }

let dummy_recover_expected_country =
  {
    id = "greenland";
    info =
      {
        name = "Greenland";
        temperature = -100;
        health_care = 50;
        density = 10;
      };
    population = { healthy = 250000; infected = 50000; dead = 0 };
    borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
  }

let dummy_kill_expected_country =
  {
    id = "greenland";
    info =
      {
        name = "Greenland";
        temperature = -100;
        health_care = 50;
        density = 10;
      };
    population = { healthy = 250000; infected = 25000; dead = 25000 };
    borders = { dry = (50, [ "us" ]); sea = 50; air = 50 };
  }

let virus_tests = [
  make_virus_upgrade_test "testing basic upgrade with dummy vals" 
    dummy_upgrade (add_points 3 Virus.init_virus) expected_upgraded_virus
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
    dummy_country (50, ["us"]);
  make_sea_access_test "testing sea access with dummy country"
    dummy_country 50;
  make_air_access_test "testing air access with dummy country"
    dummy_country 50;
  make_close_border_test "testing closing land border with dummy country"
    dummy_country DRY dummy_land_expected_country;
  make_close_border_test "testing closing sea border with dummy country"
    dummy_country SEA dummy_sea_expected_country;
  make_close_border_test "testing closing air border with dummy country"
    dummy_country AIR dummy_air_expected_country;
  make_infect_test "testing country infection with dummy country"
    dummy_country 100000 dummy_infect_expected_country;
  make_recover_test "testing country recovery with dummy country"
    dummy_infect_expected_country 50000 dummy_recover_expected_country;
  make_kill_test "testing country death with dummy country"
    dummy_recover_expected_country 25000 dummy_kill_expected_country;
]

let world_tests = [
  make_cure_progress_test "testing cure progress in dummy world" 
    World.init_world 0.0;
  make_world_pop_test "testing world population in dummy world" 
    World.init_world 300000;
  make_world_healthy_pop_test "testing world healthy population in dummy world"
    World.init_world 300000;
  make_world_infected_pop_test "testing world infected population in dummy world"
    World.init_world 0;
  make_world_dead_pop_test "testing world dead population in dummy world"
    World.init_world 0;
  make_score_test "testing player score in dummy world"
    World.init_world 0.0
]

let suite = "outbreak tests suite" >::: List.flatten [
    virus_tests;
    world_tests;
    country_tests
  ]

let _ = run_test_tt_main suite