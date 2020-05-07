open Engine
open Command
open Upgrades
open Converter

(** [print_game_msg msg] prints an unformatted game message [msg]. *)
let print_game_msg = ANSITerminal.print_string []

(** [printf_game_msg msg] prints an unformatted game message [msg]. *)
let printf_game_msg = ANSITerminal.printf []

(** [print_success msg] prints a formatted success message [msg]. *)
let print_success = ANSITerminal.print_string [ ANSITerminal.green ]

(** [print_error err] prints a formatted error message [err]. *)
let print_error = ANSITerminal.print_string [ ANSITerminal.red ]

let rec repl state =
  state |> status_str |> print_game_msg;
  try
    match read_line () with
    | exception End_of_file -> ()
    | input -> (
        match Command.parse input with
        | Quit -> exit 0
        | Upgrades ->
          let diff n = not (List.mem n state.virus.upgrades) in
          let ul = state.shop |> List.map (fun u -> u.id) |> List.filter diff in
          print_game_msg "Available upgrades:\n\n";
          List.iter (printf_game_msg "'%s', ") ul;
          print_game_msg "\n\n";
          state |> repl
        | Step l ->
          print_game_msg "Fast forwarding!\n\n";
          state |> step l |> repl
        | Buy t ->
          let name = build_phrase t in
          printf_game_msg "Buying '%s'\n" name;
          state |> purchase name |> repl)
  with Empty | Malformed ->
    print_error "Invalid command. Please try again.\n";
    repl state

let play_game =
  (* let adv = Adventure.from_json (Yojson.Basic.from_file f) in
     let st = State.init_state adv in *)
  repl 
  {
    virus = Virus.init_virus;
    world = "data/init_world.json" |> open_in |> Ezjsonm.from_channel |> world_from_json;
    shop = "data/init_shop.json" |> open_in |> Ezjsonm.from_channel |> shop_from_json;
    status = Init;
  }

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  print_game_msg "\n\nWelcome to #outbreak;;\n";
  print_game_msg "> ";
  play_game

(* Execute the game engine. *)
let () = main ()