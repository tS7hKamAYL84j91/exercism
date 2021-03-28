module Raindrops

let drops =
    [ (3, "Pling")
      (5, "Plang")
      (7, "Plong") ]

let is_divisible_by dividend divisor = (dividend % divisor) = 0

let sound_of_drops number (drop, drop_sound) =
    match is_divisible_by number drop with
    | true -> drop_sound
    | false -> ""

let default_sound number rain =
    match rain with
    | "" -> number.ToString()
    | rain -> rain

let convert (number: int) : string =
    drops
    |> List.map (sound_of_drops number)
    |> String.concat ""
    |> default_sound number
