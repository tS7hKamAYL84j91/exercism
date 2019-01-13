let is_modulo dividend ~divisor = dividend mod divisor = 0

let normalise_input str = 
  let stripped_input = Base.String.strip str in
  let digits = stripped_input 
    |> Str.split (Str.regexp "[\ ]") 
    |> Base.String.concat 
    |> Str.split (Str.regexp "") in
  let is_valid_input =  
    Base.String.length stripped_input > 1 
      && Str.string_match (Str.regexp "^[0-9\ ]+$") stripped_input 0 in
      match is_valid_input with
      | true -> Some digits
      | false -> None

let luhn_digit i x = 
  let luhn_double x = if (x * 2)  >= 10 then x * 2 - 9 else x * 2 in
    match (i+1) with
    | i' when is_modulo i' ~divisor:2 -> x |> int_of_string |> luhn_double
    | _ -> int_of_string x

let luhn_digits_sum xs = 
  xs |> List.rev |> Base.List.mapi ~f:luhn_digit |> List.fold_left (+) 0
 
let valid str = 
  str 
  |> normalise_input 
  |> Base.Option.map ~f:luhn_digits_sum 
  |> Base.Option.value ~default:1 
  |> is_modulo ~divisor:10