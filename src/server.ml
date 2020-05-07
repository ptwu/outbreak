open Opium.Std
open Converter

(** [init_state] is an Engine type that represents the initial state of
    an Outbreak game. *)
let init_state : Engine.t =
  {
    virus = Virus.init_virus;
    world = "data/init_world.json" |> open_in |> Ezjsonm.from_channel |> world_from_json;
    shop = "data/init_shop.json" |> open_in |> Ezjsonm.from_channel |> shop_from_json;
    status = Init;
  }

let game : Engine.t ref = ref init_state

let game_response g = `Json (!g |> json_of_game)

let step req =
  game := Engine.step 1 !game;
  game |> game_response |> respond'

let step_n req =
  let n = "n" |> param req |> int_of_string in
  game := Engine.step n !game;
  game |> game_response |> respond'

let init req =
  req |> App.json_of_body_exn
  |> Lwt.map (fun json ->
      let { name; starter } = json |> Ezjsonm.unwrap |> init_req_from_json in
      game := Engine.init name starter !game;
      `Json (!game |> json_of_game) |> respond)

let game_state req =
  game |> game_response |> respond'

let default req =
  `Json Ezjsonm.(dict [("message", string "Route not found")]) |> respond'

let app : Opium.App.t =
  App.empty |> App.cmd_name "#outbreak;; backend"
  |> get "/game" game_state
  |> post "/step" step
  |> post "/step/:n" step_n
  |> not_found default

let _ =
  match App.run_command' app with
  | `Ok app -> Lwt_main.run app
  | `Error -> exit 1
  | `Not_running -> exit 0