type planet =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Neptune
  | Uranus

let rec age_on planet age =
  match planet with
  | Mercury  -> (age_on Earth age) /. 0.2408467
  | Venus  -> (age_on Earth age) /. 0.61519726
  | Earth  -> (float_of_int age) /. 31557600.
  | Mars  -> (age_on Earth age) /. 1.8808158
  | Jupiter  -> (age_on Earth age) /. 11.862615
  | Saturn  -> (age_on Earth age) /. 29.447498
  | Neptune  -> (age_on Earth age) /. 164.79132
  | Uranus  -> (age_on Earth age) /. 84.016846