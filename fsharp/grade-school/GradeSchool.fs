module GradeSchool

type School = Map<int, string list>

let empty : School = Map.empty<int, string list>

let add (student: string) (grade: int) (school: School) : School =
    match Map.tryFind grade school with
    | Some students -> Map.add grade (List.sort (student :: students)) school
    | None -> Map.add grade [ student ] school

let roster (school: School) = Map.toList school |> List.collect snd

let grade (number: int) (school: School) : string list =
    Map.tryFind number school
    |> Option.defaultValue []
