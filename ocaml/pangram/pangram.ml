open Base

let is_pangram sentence = 
  sentence
    |> String.lowercase 
    |> Str.global_replace (Str.regexp "[^a-z]+") ""
    |> String.to_list 
    |> Base.List.dedup_and_sort ~compare:Char.compare
    |> List.length = 26
