module Bob

let response (input: string) =
    let shouting (input: string) =
        input = input.ToUpper()
        && input <> input.ToLower()

    let question (input: string) = (input.Trim() |> Seq.last) = '?'
    let forceFullQuestion input = shouting input && question input
    let silence (input: string) = input.Trim() = ""

    match input with
    | input when silence input -> "Fine. Be that way!"
    | input when forceFullQuestion input -> "Calm down, I know what I'm doing!"
    | input when shouting input -> "Whoa, chill out!"
    | input when question input -> "Sure."
    | _ -> "Whatever."
