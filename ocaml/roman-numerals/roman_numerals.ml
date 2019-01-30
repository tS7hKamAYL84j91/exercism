open Base 
  
let to_roman decimal_number = 
  let numerals = [
    (1000, "M"); (900, "CM"); (500, "D"); (400, "CD"); 
    (100, "C"); (90, "XC"); (50, "L"); (40, "XL"); 
    (10, "X"); (9, "IX"); (5, "V"); (4, "IV"); 
    (1, "I")
  ] in

  let rec duplicate_string n_times str = 
    if n_times = 0 then "" else str ^ duplicate_string (n_times - 1) str in

  let numeral_factor (decimal_number, rmn_nmrls) (factor, rmn_nmrl) =
     decimal_number % factor, rmn_nmrls ^ (duplicate_string (decimal_number / factor) rmn_nmrl) in

  numerals |> List.fold_left ~f:numeral_factor ~init: (decimal_number, "") |> snd