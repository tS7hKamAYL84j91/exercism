open Base

let is_modulo divisor dividend = dividend % divisor = 0

let normalise str = 
  let stripped_input = Str.global_replace (Str.regexp {| |}) "" str in
  let is_valid_input =  
    String.length stripped_input > 1 
      && Str.string_match (Str.regexp {|^[0-9]+$|}) stripped_input 0 in
  if is_valid_input then 
    Some (stripped_input |> Str.split (Str.regexp "") |> List.map ~f:Int.of_string) 
  else None

let luhn_digit i x = 
  let luhn_double x = if (x * 2) >= 10 then x * 2 - 9 else x * 2 in
  if is_modulo 2 (i+1) then luhn_double x else x

let luhn_sum xs = 
  xs |> List.rev |> List.mapi ~f:luhn_digit |> List.fold_left ~f:(+) ~init:0
 
let valid str = 
  Option.(str |> normalise |> map ~f:luhn_sum |> value ~default:1 |> is_modulo 10)