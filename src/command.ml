type object_phrase = string list

type t = 
  | Quit
  | Upgrades
  | Buy of object_phrase
  | Step of int

exception Empty

exception Malformed

let parse str =
  let list =
    str |> String.split_on_char ' ' |> List.filter (fun s -> s <> "")
  in
  match list with
  | "quit" :: _ -> Quit
  | "upgrades" :: _ -> Upgrades
  | "buy" :: t -> Buy t
  | "step" :: [] -> Step 1
  | "step" :: t :: [] ->
    (match int_of_string_opt t with 
     | Some l -> Step l
     | None -> raise Malformed)
  | [] -> raise Empty
  | _ -> raise Malformed

let build_phrase lst = String.concat " " lst