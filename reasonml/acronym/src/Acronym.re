let (||>) = (f, g, x) => x |> f |> g; /* point free function pipe */

let abbreviate =
  Js.String.splitByRe([%re {|/[.,!?:;'"-\s]+/|}])
  ||> Array.map(Js.String.charAt(0) ||> String.uppercase)
  ||> Js.Array.joinWith("");
