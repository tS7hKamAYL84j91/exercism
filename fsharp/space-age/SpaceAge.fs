module SpaceAge

type Planet =
    | Mercury
    | Venus
    | Earth
    | Mars
    | Jupiter
    | Saturn
    | Neptune
    | Uranus

let rec orbitalPeriod =
    function
    | Mercury -> orbitalPeriod Earth * 0.2408467
    | Venus -> orbitalPeriod Earth * 0.61519726
    | Earth -> 31557600.0
    | Mars -> orbitalPeriod Earth * 1.8808158
    | Jupiter -> orbitalPeriod Earth * 11.862615
    | Saturn -> orbitalPeriod Earth * 29.447498
    | Neptune -> orbitalPeriod Earth * 164.79132
    | Uranus -> orbitalPeriod Earth * 84.016846

let age (planet: Planet) (seconds: int64) : float =
    (float seconds) / (orbitalPeriod planet)
