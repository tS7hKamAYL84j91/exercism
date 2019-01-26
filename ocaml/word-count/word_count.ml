open Base

let word_count str = 
  let symbols = 
    (Str.regexp {|^'\|'$\|[:!@\$%\^&\.-]|}) in
  let update_map map word =
    Map.update map word ~f:(function
      | None -> 1
      | Some count -> count + 1) in 
  str
  |> String.lowercase
  |> String.split_on_chars ~on:[ ' ' ; '\n' ; ',' ]
  |> List.map ~f:(Str.global_replace symbols "" )
  |> List.filter ~f:(fun word -> not @@ String.equal "" word)
  |> List.fold ~f:update_map ~init:(Map.empty (module String))