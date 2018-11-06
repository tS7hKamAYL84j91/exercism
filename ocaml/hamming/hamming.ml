open Base

type nucleotide = A | C | G | T 

let cmp acc nuc = 
  match nuc with
  | (a,b) when phys_equal a b -> acc
  | _ -> acc + 1

let hamming_distance dna_1 dna_2 = 
  List.zip dna_1 dna_2 
  |> Option.map ~f:(List.fold_left ~f:(cmp) ~init:0)