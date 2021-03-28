module TwoFer

let rec twoFer =
    function
    | Some null -> twoFer None // Seems that there is some crazy programmers that could send Some null :(
    | Some name when name.Trim() = "" -> twoFer None
    | Some name -> $"One for {name}, one for me."
    | None -> "One for you, one for me."
