open Base

type nucleotide = A | C | G | T 

let cmp nuc = 
  match nuc with
  | (a,b) when phys_equal a b -> 0
  | _ -> 1

let hamming_distance (dna_1 : nucleotide list)  (dna_2 : nucleotide list) = 
  List.zip dna_1 dna_2 
  |> Option.map ~f:(List.map ~f:cmp)
  |> Option.map ~f:(List.fold_left ~f:(+) ~init:0)