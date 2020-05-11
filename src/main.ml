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

(** [repl st] is the main REPL function that prompts the user given [st]. *)
let rec repl st =
  st |> status_str |> print_game_msg;
  try
    match read_line () with
    | exception End_of_file -> ()
    | input -> (
        match Command.parse input with
        | Quit -> exit 0
        | Upgrades ->
          let diff n = not (List.mem n st.virus.upgrades) in
          let ul = st.shop |> List.map (fun u -> u.id) |> List.filter diff in
          print_game_msg "Available upgrades:\n\n";
          List.iter (printf_game_msg "'%s', ") ul;
          print_game_msg "\n\n";
          st |> repl
        | Step l ->
          print_game_msg "Fast forwarding!\n\n";
          st |> step l |> repl
        | Buy t ->
          let name = build_phrase t in
          printf_game_msg "Buying '%s'\n" name;
          st |> purchase name |> repl)
  with Empty | Malformed ->
    print_error "Invalid command. Please try again.\n";
    repl st

(** [play_game] begins the game with default values. *)
let play_game =
  "data/sample_game.json"
  |> open_in
  |> Ezjsonm.from_channel
  |> game_from_json
  |> repl

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  print_game_msg "\n\nWelcome to #outbreak;;\n";
  print_game_msg "> ";
  play_game

(* Execute the game engine. *)
let () = main ()