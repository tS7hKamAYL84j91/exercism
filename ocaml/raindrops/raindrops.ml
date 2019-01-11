let drops = [
      (3, "Pling"); 
      (5, "Plang"); 
      (7, "Plong");
      ] 

let is_divisible_by dividend divisor = 
      (dividend mod divisor) = 0 

let sound_of_drops sound (drop, drop_sound) = 
    match is_divisible_by sound drop with
      | true  -> drop_sound
      | false  -> ""

let default_sound number rain =
    match rain with 
      | "" -> string_of_int number 
      | rain  -> rain

let raindrop number =
  drops 
  |> List.map (sound_of_drops number)
  |> String.concat ""
  |> default_sound number