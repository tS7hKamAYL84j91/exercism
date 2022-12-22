module GuessingGame

let genericReply target guess : string =
    match target - guess with
    | 0 -> "Correct"
    | x when abs x < 2 -> "So close"
    | x when x > 0 -> "Too low"
    | _ -> "Too high"

let reply (guess: int) : string = genericReply 42 guess
