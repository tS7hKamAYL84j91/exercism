let anagrams = (word, anagrams) => {
  let normalise = word =>
    word
    |> String.lowercase
    |> Js.String.split("")
    |> Js.Array.sortInPlace
    |> Js.Array.join;

  let is_anagram = (word, anagram) =>
    normalise(word) == normalise(anagram)
    && word != String.uppercase(anagram);

  List.filter(is_anagram(word), anagrams);
};
