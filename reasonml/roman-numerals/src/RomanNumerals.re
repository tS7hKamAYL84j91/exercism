let toRoman = input => {
  let numerals = [
    (1, "I"),
    (4, "IV"),
    (5, "V"),
    (9, "IX"),
    (10, "X"),
    (40, "XL"),
    (50, "L"),
    (90, "XC"),
    (100, "C"),
    (400, "CD"),
    (500, "D"),
    (900, "CM"),
    (1000, "M"),
  ];

  let numberNumeralOccurances = ((roman_numerals, residual), elem) => (
    [(residual / fst(elem), snd(elem)), ...roman_numerals],
    residual mod fst(elem),
  );

  let rec fillList = (element, length) =>
    switch (element, length) {
    | (_element, length) when length <= 0 => []
    | (element, length) => [element, ...fillList(element, length - 1)]
    };

  numerals
  |> List.sort((a, b) => a <= b ? 1 : 0)  /* associated list of numerals sorted in decending order */
  |> List.fold_left(numberNumeralOccurances, ([], input))
  |> fst  /* drop temp residual value */
  |> List.rev
  |> List.map(((numberOfOccurances, numeral)) =>
       fillList(numeral, numberOfOccurances)
     )
  |> List.flatten
  |> String.concat("");
};
