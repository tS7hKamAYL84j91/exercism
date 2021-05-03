module RobotSimulator

type Direction =
    | North
    | East
    | South
    | West

type Position = int * int

type Robot =
    { direction: Direction
      position: Position }

let (+) ((x1, y1): Position) ((x2, y2): Position) = (x1 + x2, y1 + y2)

let create direction position =
    { direction = direction
      position = position }

let move instructions robot =
    let advance state =
        match state.direction with
        | North -> (0, 1)
        | South -> (0, -1)
        | East -> (1, 0)
        | West -> (-1, 0)
        |> fun pos ->
            { state with
                  position = state.position + pos }

    let turnLeft state =
        match state.direction with
        | North -> West
        | South -> East
        | East -> North
        | West -> South
        |> fun dir -> { state with direction = dir }

    let turnRight = turnLeft >> turnLeft >> turnLeft

    let execute state cmd =
        match cmd with
        | 'L' -> turnLeft state
        | 'R' -> turnRight state
        | 'A' -> advance state
        | _ -> state

    Seq.fold execute robot instructions
