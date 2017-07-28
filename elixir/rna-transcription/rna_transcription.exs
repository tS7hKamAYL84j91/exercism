defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: dna |> Enum.map(&nucleotide_binding/1)

  def nucleotide_binding(?A), do: ?U
  def nucleotide_binding(?C), do: ?G
  def nucleotide_binding(?T), do: ?A
  def nucleotide_binding(?G), do: ?C

end
