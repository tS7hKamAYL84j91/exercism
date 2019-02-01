let isPangram = sentence =>
  sentence
  |> String.lowercase
  |> Js.String.replaceByRe([%re "/[^a-z]/g"], "")
  |> Js.String.split("")
  |> Array.to_list
  |> List.sort_uniq(String.compare)
  |> List.length == 26;