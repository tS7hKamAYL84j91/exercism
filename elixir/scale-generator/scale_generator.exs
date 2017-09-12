defmodule ScaleGenerator do

  @chromatic_scale_pitches  ~w(A A# B C C# D D# E F F# G G#)
  @flat_scale_pitches ~w(A Bb B C Db D Eb E F Gb G Ab)
  @num_of_pitches_chromatic_scale 13
  @flat_tonics ~w(F Bb Eb Ab Db Gb d g c f bb eb)

  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) :: list(String.t())
  def step(scale, tonic, "m"), do: scale |> chromatic_scale(tonic, 2) |> List.last
  def step(scale, tonic, "M"), do: scale |> chromatic_scale(tonic, 3) |> List.last
  def step(scale, tonic, "A"), do: scale |> chromatic_scale(tonic, 4) |> List.last
  

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C"), do: @chromatic_scale_pitches |> chromatic_scale(tonic)

  defp chromatic_scale(pitches,tonic, num_of_pitches \\ @num_of_pitches_chromatic_scale) do
    pitches 
    |> Stream.cycle 
    |> Stream.drop(pitches |> Enum.find_index(&(&1 == tonic |> String.capitalize))) 
    |> Enum.take(num_of_pitches)
  end



  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C"),  do: @flat_scale_pitches |> chromatic_scale(tonic)


  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) when tonic in @flat_tonics, do: tonic |> flat_chromatic_scale 
  def find_chromatic_scale(tonic), do: tonic |> chromatic_scale 
  

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    with  cs <- tonic |> find_chromatic_scale, do:  
      [cs |> hd | pattern 
      |> String.codepoints 
      |> Enum.scan(cs |> hd, fn stp, acc -> step(cs, acc, stp) end)]
  end



end

