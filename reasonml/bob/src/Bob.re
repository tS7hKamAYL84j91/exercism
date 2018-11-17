let hey = input => {
  let shouting = input =>
    String.uppercase(input) == input && String.lowercase(input) != input;
  let question =
    fun
    | "" => false
    | input => String.sub(input, String.length(input) - 1, 1) == "?";
  let shouting_a_question = input => shouting(input) && question(input);
  let silence = input => input == "";
  let response =
    fun
    | input when shouting_a_question(input) => "Calm down, I know what I'm doing!"
    | input when shouting(input) => "Whoa, chill out!"
    | input when question(input) => "Sure."
    | input when silence(input) => "Fine. Be that way!"
    | _ => "Whatever.";

  input |> String.trim |> response;
};
