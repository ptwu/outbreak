type object_phrase = string list

type command = 
  | Quit
  | Upgrades
  | Buy of object_phrase
  | Progress
  | Cure

exception Empty

exception Malformed

let rec checkempty lst =
  match lst with
  | [] -> []
  | h :: t -> if (h = "") then checkempty t else h :: checkempty t

let parse str =
  let word_list = String.split_on_char ' ' str in
  let w_list = checkempty word_list in
  match w_list with
  | [] -> raise Empty
  | h :: t ->
    if (h = "upgrades") then Upgrades
    else if (h = "quit") then Quit
    else if (h = "progress") then Progress
    else if (h = "cure") then Cure
    else if (h = "buy")
    then
      (if (t = []) then raise Malformed
       else Buy t)
    else raise Malformed