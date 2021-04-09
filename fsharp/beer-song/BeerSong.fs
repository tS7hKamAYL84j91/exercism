module BeerSong

let recite (startBottles: int) (takeDown: int) =
    let verse numberOfBottles =
        let verseSpacer = ""

        let bottlesOnTheWallLine =
            function
            | 0 -> "No more bottles of beer on the wall, no more bottles of beer."
            | 1 -> $"1 bottle of beer on the wall, 1 bottle of beer."
            | n -> $"{n} bottles of beer on the wall, {n} bottles of beer."

        let whatWillWeDoLine =
            function
            | 0 -> "Go to the store and buy some more, 99 bottles of beer on the wall."
            | 1 -> "Take it down and pass it around, no more bottles of beer on the wall."
            | 2 -> "Take one down and pass it around, 1 bottle of beer on the wall."
            | n -> $"Take one down and pass it around, {n - 1} bottles of beer on the wall."

        [ verseSpacer
          bottlesOnTheWallLine numberOfBottles
          whatWillWeDoLine numberOfBottles ]

    [ startBottles .. (-1) .. (startBottles - takeDown + 1) ]
    |> List.map verse
    |> List.concat
    |> List.tail
