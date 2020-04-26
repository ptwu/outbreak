open Engine

(** [print_game_msg msg] prints an unformatted game message [msg]. *)
let print_game_msg = ANSITerminal.print_string []

(** [print_success msg] prints a formatted success message [msg]. *)
let print_success = ANSITerminal.print_string [ ANSITerminal.green ]

(** [print_error err] prints a formatted error message [err]. *)
let print_error = ANSITerminal.print_string [ ANSITerminal.red ]

let rec repl state =
  state |> status |> print_game_msg;
  match read_line () with
  | exception End_of_file -> ()
  | input -> (
      match Command.parse input with
      | Quit -> exit 0
      | Upgrades -> print_game_msg "Upgrades here"
      | Step l ->
        print_game_msg "Fast forwarding!\n\n";
        state |> step l |> repl
      | Buy t ->
        (*begin match State.go (String.concat " " t) adv st with
          | Illegal -> print_string "You can't do that!"; command_loop adv st
          | Legal next -> command_loop adv next
          end*)
        print_game_msg "Buy upgrade here" )

let play_game =
  (* let adv = Adventure.from_json (Yojson.Basic.from_file f) in
     let st = State.init_state adv in *)
  repl Engine.init_state

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  print_game_msg "\n\nWelcome to #outbreak;;\n";
  print_game_msg "> ";
  play_game

(* Execute the game engine. *)
let () = main ()