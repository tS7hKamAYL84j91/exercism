let encode = str =>
  Js.String.unsafeReplaceBy1(
    [%re {|/(.)\1+/g|}],
    (matched_str, chr, _, _) => {
      let len = String.length(matched_str);
      {j|$(len)$(chr)|j};
    },
    str,
  );

let decode = str =>
  Js.String.unsafeReplaceBy2(
    [%re {|/(\d+)(\D)/g|}],
    (_, len, chr, _, _) => Js.String.repeat(len |> int_of_string, chr),
    str,
  );