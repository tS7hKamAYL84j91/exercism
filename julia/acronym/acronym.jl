punctuation = r"""[ \-_]"""

acronym(phrase) =
  split(phrase, punctuation, keepempty=false) |> phrase -> map(first, phrase) |> join |> uppercase
