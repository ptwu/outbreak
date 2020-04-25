(** [print_msg attr msg] prints [msg] formatted with [attr]. *)
let print_msg attr = ANSITerminal.(print_string attr)

(** [print_success msg] prints a formatted success message [msg]. *)
let print_game_msg = print_msg []

(** [print_success msg] prints a formatted success message [msg]. *)
let print_success = print_msg [ ANSITerminal.green ]

(** [print_error err] prints a formatted error message [err]. *)
let print_error = print_msg [ ANSITerminal.red ]

let rec command_loop =
  print_game_msg "Game text here";
  match read_line () with
  | exception End_of_file -> ()
  | input -> (
      match Command.parse input with
      | Quit -> exit 0
      | Upgrades -> print_game_msg "Upgrades here"
      | Progress -> print_game_msg "Virus progress here"
      | Cure -> print_game_msg "Cure here"
      | Buy t ->
          (*begin match State.go (String.concat " " t) adv st with
            | Illegal -> print_string "You can't do that!"; command_loop adv st
            | Legal next -> command_loop adv next
            end*)
          print_game_msg "Buy upgrade here" )

let play_game =
  (* let adv = Adventure.from_json (Yojson.Basic.from_file f) in
     let st = State.init_state adv in *)
  command_loop

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  print_game_msg "\n\nWelcome to #outbreak;;\n";
  print_game_msg "> ";
  play_game

(* Execute the game engine. *)
let () = main ()
