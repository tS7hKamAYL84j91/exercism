let is_isogram = sentence => {
  let normalised_sentence =
    sentence
    |> String.lowercase
    |> Js.String.replaceByRe([%re {|/[\-\s]/g|}], "");

  normalised_sentence
  |> Js.String.split("")
  |> Array.to_list
  |> List.sort_uniq(String.compare)
  |> List.length == String.length(normalised_sentence);
};