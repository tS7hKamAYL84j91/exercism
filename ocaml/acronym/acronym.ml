open Base

let acronym words =  
  words 
  |> Str.split (Str.regexp "[-; ]+")
  |> List.map ~f:(fun x -> Str.first_chars x 1)
  |> String.concat  
  |> String.uppercase  