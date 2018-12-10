let toList = score => {
  let allergens = [
    (1, "eggs"),
    (2, "peanuts"),
    (4, "shellfish"),
    (8, "strawberries"),
    (16, "tomatoes"),
    (32, "chocolate"),
    (64, "pollen"),
    (128, "cats"),
  ];

  let allergen_test = ((allergen_score, _)) =>
    score land allergen_score == allergen_score;

  allergens |> List.filter(allergen_test) |> List.map(snd);
};

let isAllergicTo = (name, score) =>
  score |> toList |> List.exists((==)(name));
