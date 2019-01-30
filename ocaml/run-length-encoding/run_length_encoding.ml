
open Base

let encode str = 
  let encoder = function
  | [] -> ""
  | x :: [] -> x
  | x :: _tl as xs -> (Int.to_string @@ List.length xs) ^ x in
  str
  |> Str.split @@ Str.regexp {||}  
  |> List.group ~break:(fun x y -> not @@ String.equal x y) 
  |> List.map ~f:encoder
  |> String.concat ~sep:""


let decode str =
  let is_digit x = Str.string_match (Str.regexp {|^[0-9]$|}) x 0 in
  let rec duplicate_string n s = if n = 0 then "" else s ^ duplicate_string (n - 1) s in  
  let parse acc x = match acc with
    | (c, None) :: tl when is_digit x -> (Int.of_string @@ (Int.to_string c) ^ x, None) :: tl
    | acc when is_digit x -> (Int.of_string x, None) :: acc
    | (c, None) :: tl -> (c, Some x) :: tl
    | acc -> (1, Some x) :: acc in
  str 
  |> Str.split (Str.regexp {||}) 
  |> List.fold_left ~f:parse ~init:[] 
  |> List.rev 
  |> List.map ~f:(function 
    | (c, Some v) -> duplicate_string c v
    | (_, None) -> "")
  |> String.concat ~sep:""