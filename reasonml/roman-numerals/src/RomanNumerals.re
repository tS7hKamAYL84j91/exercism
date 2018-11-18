let toRoman = input => {
  
let explode = s => {
  let rec exp = (i, l) => switch (i,l) {
  | (i, l) when i < 0 => l
  | (i, l) => exp(i - 1, [s.[i], ...l])
  };   
  exp(String.length(s) - 1, []);
};

let rec numerals = fun
  | [] => []
  | ['I', 'V', ...xs] => [4, ...numerals(xs)]
  | ['I', 'X', ...xs] => [9, ...numerals(xs)]
  | ['X', 'L', ...xs] => [40, ...numerals(xs)]
  | ['X', 'C', ...xs] => [90, ...numerals(xs)]
  | ['C', 'D', ...xs] => [400, ...numerals(xs)]
  | ['C', 'M', ...xs] => [900, ...numerals(xs)]
  | ['I', ...xs] => [1, ...numerals(xs)]
  | ['V', ...xs] => [5, ...numerals(xs)]
  | ['X', ...xs] => [10, ...numerals(xs)]
  | ['L', ...xs] => [50, ...numerals(xs)]
  | ['C', ...xs] => [100, ...numerals(xs)]
  | ['M', ...xs] => [1000, ...numerals(xs)]
  | [_, ...xs] => [0, ...numerals(xs)];
input |> string_of_int |> explode |> numerals |> List.fold_left((+),0) |> string_of_int;
};

