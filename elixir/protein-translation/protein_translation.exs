defmodule ProteinTranslation do
  @proteins [UGU: "Cysteine",
    UGC: "Cysteine",
    UUA: "Leucine",
    UUG: "Leucine",
    AUG: "Methionine",
    UUU: "Phenylalanine",
    UUC: "Phenylalanine",
    UCU: "Serine",
    UCC: "Serine",
    UCA: "Serine",
    UCG: "Serine",
    UGG: "Tryptophan",
    UAU: "Tyrosine",
    UAC: "Tyrosine",
    UAA: "STOP",
    UAG: "STOP",
    UGA: "STOP"]
  @codon_err "invalid codon"
  @rna_err "invalid RNA"
     
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    rna
    |> String.split(~r{\w\w\w}, include_captures: true, trim: true)
    |> Enum.map(&of_codon/1)
    |> Enum.take_while(&(&1 != {:ok,"STOP"}))
    |> lift_rna
  end

  defp lift_rna(xs) do
    if Enum.any?(xs, &(elem(&1,0)==:error)) do
      {:error, @rna_err}
    else
      {:ok, xs |> Keyword.values}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """

  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    @proteins
    |> Keyword.fetch(codon |> String.to_atom)
    |> lift_codon_result
  end

  defp lift_codon_result(:error), do: {:error,@codon_err}
  defp lift_codon_result(result), do: result


end

