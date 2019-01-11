open Base

let is_pangram sentence = 
  sentence
    |> Str.global_replace (Str.regexp "[^a-zA-Z]+") ""
    |> String.lowercase 
    |> String.to_list 
    |> Base.List.dedup_and_sort ~compare:Char.compare
    |> String.of_char_list 
    |> String.equal "abcdefghijklmnopqrstuvwxyz"
