type dna =
  | A
  | C
  | G
  | T;

type rna =
  | A
  | C
  | G
  | U;

let toRna = dna => {
  let transcribeDnaNucleotide =
    fun
    | (A: dna) => U
    | C => G
    | G => C
    | T => A;
  let fmap_transcribeDna = List.map(transcribeDnaNucleotide);
  fmap_transcribeDna(dna);
};
