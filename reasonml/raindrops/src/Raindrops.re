let raindrops = number => {
  let drops = [(3, "Pling"), (5, "Plang"), (7, "Plong")];

  let is_divisible_by = (dividend, divisor) => dividend mod divisor == 0;

  let sound_of_drops = (sound, (drop, drop_sound)) =>
    sound ++ (is_divisible_by(number, drop) ? drop_sound : "");

  let sound_of_rain = rain => rain == "" ? string_of_int(number) : rain;

  drops |> List.fold_left(sound_of_drops, "") |> sound_of_rain;
};
