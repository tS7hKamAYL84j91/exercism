module GradeSchool

type School = Map<int, string list>

let empty : School = Map.empty<int, string list>

let add (student: string) (grade: int) (school: School) : School =
    let addStudentToClass student students =
        match students with
        | Some students -> Some(List.sort (student :: students))
        | None -> Some(student :: [])

    Map.change grade (addStudentToClass student) school

let roster (school: School) =
    Map.fold (fun acc _ students -> acc @ students) [] school

let grade (number: int) (school: School) : string list =
    if Map.containsKey number school then
        Map.find number school
    else
        []
