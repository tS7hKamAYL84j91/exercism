let drops = [(3, "Pling"); (5, "Plang"); (7, "Plong")] 

let is_divisible_by dividend divisor = (dividend mod divisor) = 0 

let sound_of_drops sound (drop, drop_sound) = 
    match is_divisible_by sound drop with
      | true  -> drop_sound
      | false  -> ""

let sound_of_rain number rain =
    match rain = "" with 
      | true  -> string_of_int number 
      | false  -> rain

let raindrop number =
  drops 
  |> List.fold_left (fun acc x -> acc ^ sound_of_drops number x) "" 
  |> sound_of_rain number