open Opium.Std
open Converter

(** [init_state] is an Engine type that represents the initial state of
    an Outbreak game. *)
let init_state : Engine.t =
  {
    virus = Virus.init_virus;
    world = "data/init_world.json" |> open_in |> Ezjsonm.from_channel |> world_from_json;
    shop = "data/init_shop.json" |> open_in |> Ezjsonm.from_channel |> shop_from_json;
  }

let game : Engine.t ref = ref init_state

let print_param =
  put "/hello/:name" (fun req ->
      `String ("Hello " ^ param req "name") |> respond')

let step =
  post "/step" (fun req ->
      game := Engine.step 1 !game;
      `String ("Stepped 1 times.") |> respond')

let step_n =
  post "/step/:n" (fun req ->
      let n = "n" |> param req |> int_of_string in
      game := Engine.step n !game;
      `String (Printf.sprintf "Stepped %d times" n) |> respond')

let game_state =
  get "/game" (fun req ->
      `Json (!game |> json_of_game) |> respond')

let default =
  not_found (fun _req ->
      `Json Ezjsonm.(dict [("message", string "Route not found")]) |> respond')

let app : Opium.App.t =
  App.empty |> App.cmd_name "#outbreak;; backend" |> game_state |> step |> step_n |> default

let _ =
  match App.run_command' app with
  | `Ok app -> Lwt_main.run app
  | `Error -> exit 1
  | `Not_running -> exit 0