pub fn raindrops(n: u32) -> String {
  let drops = [(3, "Pling"), (5, "Plang"), (7, "Plong")];

  let sound_of_the_rain = |sound: Option<String>, &(drop, drop_sound)| match n % drop {
    0 => Some(sound.unwrap_or(String::new()) + drop_sound),
    _ => sound,
  };

  drops
    .iter()
    .fold(None, sound_of_the_rain)
    .unwrap_or(n.to_string())
}
