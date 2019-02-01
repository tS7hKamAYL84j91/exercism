let codec = (reducer, mapper, str) => {
  let to_canonical_form = str =>
    str |> Js.String.split("") |> Array.fold_left(reducer, []) |> List.rev;
  let format_output = str => str |> List.map(mapper) |> String.concat("");

  str |> to_canonical_form |> format_output;
};

let encode = str => {
  let parse_input = (acc, x) =>
    switch (acc) {
    | [(count, str), ...accs] when str == x => [(count + 1, str), ...accs]
    | accs => [(1, x), ...accs]
    };
  let encode_occurances = ((count, str)) =>
    count > 1 ? string_of_int(count) ++ str : str;

  codec(parse_input, encode_occurances, str);
};

let decode = str => {
  let is_digit = x => Js.String.match([%re {|/^[0-9]$/|}], x) != None;
  let concat_digit = (count, x) =>
    int_of_string @@ string_of_int(count) ++ x;
  let parse_input = (acc, x) =>
    switch (acc) {
    | [(count, None), ...tl] when is_digit(x) => [
        (concat_digit(count, x), None),
        ...tl,
      ]
    | acc when is_digit(x) => [(int_of_string(x), None), ...acc]
    | [(count, None), ...tl] => [(count, Some(x)), ...tl]
    | acc => [(1, Some(x)), ...acc]
    };
  let decode_occurances =
    fun
    | (count, Some(str)) => Js.String.repeat(count, str)
    | (_, None) => "";

  codec(parse_input, decode_occurances, str);
};