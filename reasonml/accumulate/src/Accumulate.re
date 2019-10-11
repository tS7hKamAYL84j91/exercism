/* comment */
let rec accumulate = (f, xs) =>
  switch (xs) {
  | [] => []
  | [x, ...xs'] => [f(x), ...accumulate(f, xs')]
  };
