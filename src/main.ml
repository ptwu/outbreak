(** [print_msg attr msg] prints [msg] formatted with [attr]. *)
let print_msg attr = ANSITerminal.(print_string attr)

(** [print_success msg] prints a formatted success message [msg]. *)
let print_game_msg = print_msg [ ANSITerminal.red ]

(** [print_success msg] prints a formatted success message [msg]. *)
let print_success = print_msg [ ANSITerminal.green ]

(** [print_error err] prints a formatted error message [err]. *)
let print_error = print_msg [ ANSITerminal.red ]

(** [repl adv state] prompts for the next action in state [state] of [adv]. *)
(* let rec repl adv state =
  state |> sim_description adv |> print_endline;
  state |> list_items (Room (current_room_id state)) adv |> print_items;
  try
    match () |> read_line |> parse with
    | Go t -> handle_go state (repl adv) (go (build_phrase t) adv state)
    | Take t ->
      let input_item = build_phrase t in 
      handle_take input_item state (repl adv) (take input_item adv state)
    | Drop t -> 
      let input_item = build_phrase t in 
      handle_drop input_item adv state (repl adv) (drop input_item adv state)
    | Unlock t -> handle_unlock state (repl adv) (unlock (build_phrase t) adv state)
    | Lock t -> handle_lock state (repl adv) (lock (build_phrase t) adv state)
    | Inventory ->
      list_items Inventory adv state |> print_inv;
      repl adv state
    | Look ->
      let curr_room = Room (current_room_id state) in
      list_items curr_room adv state |> print_items;
      repl adv state
    | Score ->
      print_score (score adv state);
      repl adv state
    | Quit -> ()
  with Empty | Malformed ->
    print_error "Invalid command. Please try again.\n";
    repl adv state *)

(** [play_game f] starts the adventure in file [f]. *)
let play_game f =
  try
    ();
  with Sys_error err -> print_error err

(** [main ()] prompts for the game to play, then starts it. *)
let main () =
  print_game_msg "Welcome to #outbreak;;";
  print_endline "[game intro text placeholder]";
  match read_line () with
  | exception End_of_file -> ()
  | file_name -> play_game file_name

(* Execute the game engine. *)
let () = main ()
