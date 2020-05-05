open Opium.Std
open Converter

let game : Engine.t ref = ref Engine.init_state

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

let _ =
  App.empty |> game_state |> step |> step_n |> default |> App.run_command