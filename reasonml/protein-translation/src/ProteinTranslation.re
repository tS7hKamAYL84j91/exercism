let protiens_of_string =
  fun
  | "AUG" => Some("Methionine")
  | "UUU"
  | "UUC" => Some("Phenylalanine")
  | "UUA"
  | "UUG" => Some("Leucine")
  | "UCU"
  | "UCC"
  | "UCA"
  | "UCG" => Some("Serine")
  | "UAU"
  | "UAC" => Some("Tyrosine")
  | "UGU"
  | "UGC" => Some("Cysteine")
  | "UGG" => Some("Tryptophan")
  | _ => None;

let rec take_while = (f, xs) =>
  switch (xs) {
  | [x, ...xs'] when f(x) == true => [x, ...take_while(f, xs')]
  | _ => []
  };

let proteins = str =>
  Js.String.match([%re "/.{1,3}/g"], str)
  ->Belt.Option.map(x => x |> Array.to_list |> List.map(protiens_of_string))
  ->Belt.Option.getWithDefault([])
  |> take_while(x => x != None)
  |> List.map(Belt.Option.getExn);
