pub fn raindrops(n: u32) -> String {
  let drops: [(u32, &'static str); 3] = [(3, "Pling"), (5, "Plang"), (7, "Plong")];
  let sound_of_rain = |sound, (drop, drop_sound)| if sound % drop == 0 { drop_sound } else { "" };
  let default_sound = |rain: String, number: u32| match rain.as_str() {
    "" => number.to_string(),
    _ => rain,
  };

  default_sound(
    drops
      .iter()
      .map(|s| -> &str { sound_of_rain(n, *s) })
      .collect::<String>(),
    n,
  )
}
