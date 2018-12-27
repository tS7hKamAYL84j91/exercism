type base = int

let decimal_to_digits base decimal = 
  let rec base_conversion decimal digits =
    match (decimal / base) with
    | 0 -> decimal mod base :: digits
    | quotient -> base_conversion quotient (decimal mod base :: digits) in
  base_conversion decimal [] 

let digits_to_decimal base digits = 
  let pow number exponent = 
    int_of_float (Float.pow (float_of_int number) (float_of_int exponent)) in
  digits |> List.rev |> List.mapi (fun i x -> x * pow base i) |> List.fold_left (+) 0

let convert_bases ~from ~digits ~target = 
  let invalid_base from target = from <= 1 || target <= 1 in
  let invalid_digits from digits = List.filter (fun i -> i >= from || i < 0) digits != [] in
  match (from, digits, target) with 
    |(from, _, target) when invalid_base from target -> None
    |(from, digits, _) when invalid_digits from digits  -> None
    |(from, digits, target) -> Some (digits_to_decimal from digits |> decimal_to_digits target)