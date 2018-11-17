let validate = digits => {
  let power = base =>
    float_of_int(base)
    ** float_of_int(string_of_int(digits) |> String.length)
    |> int_of_float;
  let rec armstrong_sum =
    fun
    | (sum, x) when x <= 0 => sum
    | (sum, x) => armstrong_sum((sum + power(x mod 10), x / 10));
  armstrong_sum((0, digits)) == digits;
};
