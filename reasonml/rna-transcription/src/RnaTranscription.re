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
  let transcribeDnaNucleotide = (nucleotide: dna): rna =>
  switch (nucleotide) {
  | A => U
  | C => G
  | G => C
  | T => A
  };  
  dna |> List.map(transcribeDnaNucleotide);
};
