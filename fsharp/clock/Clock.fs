module Clock

type Clock = { minutes: int }

let minsInHour = 60
let hoursInDay = 24
let minsInDay = minsInHour * hoursInDay

let create hours minutes =
    let moderateClock minutes : int =
        match minutes % minsInDay with
        | r when r < 0 -> r + minsInDay
        | r -> r

    { minutes = (hours * minsInHour + minutes) |> moderateClock }

let add minutes clock = create 0 (clock.minutes + minutes)
let subtract minutes clock = add -minutes clock

let display clock =
    $"%02i{clock.minutes / minsInHour}:%02i{clock.minutes % minsInHour}"
