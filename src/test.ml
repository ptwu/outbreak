open OUnit2
open Virus
open Country
open World

(** [make_virus_upgrade_test name offsets init expected_output] constructs an 
    OUnit test named [name] that asserts the quality of [expected_output]
    with [upgrade offsets init]. *)
let make_virus_upgrade_test
    (name : string) 
    (offsets: Virus.t)
    (init: Virus.t) 
    (expected_output : Virus.t) : test = 
  name >:: (fun _ -> 
      assert_equal expected_output (upgrade offsets init))

let upgrade_vector =  {
  infectivity = 2;
  severity = 1;
  hality = 10;
  heat_res = 1;
  cold_res = 2;
  drug_res = 4;
  anti_cure = 6;
}

let expected_upgraded_virus =  {
  infectivity = 3;
  severity = 2;
  hality = 11;
  heat_res = 1;
  cold_res = 2;
  drug_res = 4;
  anti_cure = 6;
}

let virus_tests = [
  make_virus_upgrade_test "testing basic upgrade with dummy vals" 
    upgrade_vector Virus.init_virus expected_upgraded_virus
]

let suite = "outbreak tests suite" >::: List.flatten [
    virus_tests
  ]

let _ = run_test_tt_main suite