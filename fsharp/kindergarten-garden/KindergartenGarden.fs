module KindergartenGarden

type Plant =
    | Grass
    | Clover
    | Radishes
    | Violets
    | None

let plants (diagram: string) student =
    let numberOfPlantsPerRow = 2

    let studentIndex (student: string) = int (student.[0]) - int 'A'

    let plantsInRow student (diagram: string) =
        (studentIndex student) * numberOfPlantsPerRow
        |> fun indx -> diagram.[indx..indx + 1]
        |> Seq.toList

    let plantType =
        function
        | 'G' -> Grass
        | 'C' -> Clover
        | 'R' -> Radishes
        | 'V' -> Violets
        | _ -> None

    diagram.Split('\n')
    |> Seq.toList
    |> List.map (plantsInRow student)
    |> List.concat
    |> List.map plantType
