let decimal_to_digits = (base, decimal) => {
  let rec base_conversion = (decimal, digits) =>
    switch (decimal / base) {
    | 0 => [decimal mod base, ...digits]
    | quotient => base_conversion(quotient, [decimal mod base, ...digits])
    };
  base_conversion(decimal, []);
};

let digits_to_decimal = (base, digits) =>
  digits
  |> List.rev
  |> List.mapi((i, x) => x * Js.Math.pow_int(~base, ~exp=i))
  |> List.fold_left((+), 0);

let rebase = (from, digits, target) => {
  let invalid_base = (from, target) => from <= 1 || target <= 1;
  let invalid_digits = (from, digits) =>
    List.filter(i => i >= from || i < 0, digits) !== []
    or List.filter(i => i == 0, digits) == digits;
  switch (from, digits, target) {
  | (_, [], _) => None
  | (from, _, target) when invalid_base(from, target) => None
  | (from, digits, _) when invalid_digits(from, digits) => None
  | (from, digits, target) =>
    Some(digits_to_decimal(from, digits) |> decimal_to_digits(target))
  };
};