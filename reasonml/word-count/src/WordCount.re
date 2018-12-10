let to_words = input =>
  input
  |> String.trim
  |> String.lowercase
  |> Js.String.replaceByRe([%re "/[^\w\s']|_/g"], "")
  |> Js.String.replaceByRe([%re "/'([a-zA-Z]+)'/g"], "$1")
  |> Js.String.splitByRe([%re "/[\s]+/g"])
  |> Array.to_list;

let count_words = input => {
  let reducer = (acc, x) =>
    switch (acc, x) {
    | ([(word, n), ...tl], x) when x == word => [(word, n + 1), ...tl]
    | (acc, x) => [(x, 1), ...acc]
    };

  input |> List.sort(String.compare) |> List.fold_left(reducer, []);
};

let wordCount = input => input |> to_words |> count_words |> Js.Dict.fromList;
