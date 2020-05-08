open Opium.Std
open Converter

let port = 3000

(** [init_state] is an Engine type that represents the initial state of
    an Outbreak game. *)
let init_state : Engine.t =
  "data/sample_game.json"
  |> open_in
  |> Ezjsonm.from_channel
  |> game_from_json

let game : Engine.t ref = ref init_state

let game_response g = `Json (!g |> json_of_game)

let game_state req =
  game |> game_response |> respond'

let handle_reset_body body =
  game := body |> Ezjsonm.value |> game_from_json;
  game |> game_response |> respond

let reset req =
  req |> App.json_of_body_exn |> Lwt.map handle_reset_body

let handle_init_body body =
  let { name; starter } = body |> Ezjsonm.value |> init_req_from_json in
  game := Engine.init name starter !game;
  game |> game_response |> respond

let init req =
  req |> App.json_of_body_exn |> Lwt.map handle_init_body

let purchase req =
  let id = "id" |> param req in
  game := Engine.purchase id !game;
  game |> game_response |> respond'

let step req =
  game := Engine.step 1 !game;
  game |> game_response |> respond'

let step_n req =
  let n = "n" |> param req |> int_of_string in
  game := Engine.step n !game;
  game |> game_response |> respond'

let default req =
  `Json Ezjsonm.(dict [("message", string "Route not found")]) |> respond'

let app : Opium.App.t =
  App.empty
  |> App.cmd_name "#outbreak;; backend"
  |> App.port port
  |> get "/game" game_state
  |> post "/reset" reset
  |> post "/init" init
  |> post "/purchase/:id" purchase
  |> post "/step" step
  |> post "/step/:n" step_n
  |> not_found default

let _ =
  match App.run_command' app with
  | `Ok app ->
    Printf.sprintf "starting #outbreak;; server on port %i \n" port |> print_endline;
    Lwt_main.run app
  | `Error -> exit 1
  | `Not_running -> exit 0