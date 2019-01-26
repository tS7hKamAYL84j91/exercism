open Base
open Printf

let num_of_bottles = function
  | 0 -> "no more bottles"
  | 1 -> "1 bottle"
  | n -> sprintf "%d bottles" n

let sentance_1 number = 
  sprintf "%s of beer on the wall, %s of beer.\n"
    (number |> num_of_bottles |> String.capitalize)
    (number |> num_of_bottles)

let sentance_2 = function
  | 0 -> sprintf "Go to the store and buy some more, %s of beer on the wall.\n" @@ num_of_bottles 99
  | 1 -> sprintf "Take it down and pass it around, %s of beer on the wall.\n"   @@ num_of_bottles 0
  | n -> sprintf "Take one down and pass it around, %s of beer on the wall.\n"  @@ num_of_bottles (n - 1)

let verse number = sentance_1 number ^ sentance_2 number

let lyrics ~from ~until = 
  List.range from (until - 1) ~stride:(-1)
  |>  List.map ~f:verse
  |>  String.concat ~sep:"\n"