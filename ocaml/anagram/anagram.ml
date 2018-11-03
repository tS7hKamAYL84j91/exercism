open Base

let normalise word  =  
  word |> String.lowercase |> String.to_list |> List.sort ~compare:Char.compare |> String.of_char_list 

let is_anagram word candidate =  
  String.(normalise candidate = normalise word) && String.(String.lowercase word <> String.lowercase candidate)

let anagrams word candidates =  List.filter ~f:(is_anagram word) candidates


