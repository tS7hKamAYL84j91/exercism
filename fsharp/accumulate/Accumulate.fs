module Accumulate

let reverseList input =
    let rec loop input acc =
        match input with
        | [] -> acc
        | x :: xs -> loop xs (x :: acc)

    loop input []

let accumulate (func: 'a -> 'b) (input: 'a list) : 'b list =
    let rec loop (func: 'a -> 'b) (input: 'a list) (acc: 'b list) =
        match input with
        | [] -> reverseList acc
        | x :: xs -> loop func xs (func x :: acc)

    loop func input []
