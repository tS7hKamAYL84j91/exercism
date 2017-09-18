defmodule Markdown do
  @enclose_tags [
    {"# ", "h1"},
    {"## ", "h2"},
    {"### ", "h3"},
    {"#### ", "h4"},
    {"##### ", "h5"},
    {"###### ", "h6"},
    {"* ","li"},
    {"", "p"}]


  @enclose_tag ""
  @li_tag "* "
  @ul_html_tag "ul"

  @md_to_html_tags [
    {"__", "strong"}, 
    {"_", "em"}]

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"

    1 - parse: refacatored to use pipe operator, replaced anonymous fn with &fn_name/arity
    2 - parse_line: replace if statements with pattern matching
    3 - parse_line: replaced nesting with pipe operator
    4 - parse_header_md_level: moved String.split into parse_line , refactored to use pipe operator 
    5 - enclose_with_list_tag: moved String.split into parse_line , refactored to use pipe operator
    6 - enclose_with_list_tag: pattern match updated to remove '* ' from beginning of line, replaced string concat with interpolation
    7 - enclose_with_header_tag: replaced string concat with interpolation
    8 - enclose_with_paragraph_tag: refactored to single line func 
    9 - join_words_with_tags:  refacatored to use pipe operator, replaced anonymous fn with &fn_name/arity
    10 - replace_preix/postfix_md: removed condition statement
    11 - parse_block: refactoed parse_block to use pipe operator
    12 - replace_preix/postfix_md: replaced String.replace(regex) with String.replace_prefix/suffix
    13 - parse_list_md_level: to to enclose_with_list_tag to align function name
    14 - enclose_with_<x>_tag/1: replaced with enclose_with_tag/2 general function
    15 - replaced parse_line logic with pattern matching and refactored out duplicate code
    16 - refactored out duplicate code from md_to_html_tags
    17 - renamed process -> parse_line, and gave varibles sensible names
    18 - replaced parse_line with some meta programming and dat
    19 - replaced md_to_html_tags with data and reduce function
    20 - refactored enclose_with_tag to use the inline_tag function
    21 - renamed process_md_line as parse_line
  """
  @spec parse(String.t) :: String.t
  def parse(md) do 
    md 
    |> String.split("\n") 
    |> Enum.reduce({"",[]}, &parse_block/2)
    |> parse_block 
  end

  def parse_block({output, []}), do: output
  def parse_block({output, li}), do: output <> (li |> Enum.join |> md_to_html_tags(@enclose_tag, @ul_html_tag))
  
  def parse_block(@li_tag <> t = m , {output, li}), do: {output, li ++ [m |> parse_line]}
  def parse_block(m, {output, [h|t]=li}), do: m |> parse_block({output <> (li |> Enum.join |> md_to_html_tags(@enclose_tag, @ul_html_tag)), []})
  def parse_block(m, {output, []}), do: {output <> m |> parse_line, []}

  
  for {md_tag, html_tag} <- @enclose_tags do
    defp parse_line(unquote(md_tag) <> md), do: md |> parse_line(unquote(html_tag)) 
  end 
  
  defp parse_line(md, html_tag) do 
    md 
    |> String.split
    |> Enum.map_join(" ", &md_to_html_tags/1)
    |> md_to_html_tags(@enclose_tag, html_tag)
  end
  
  defp md_to_html_tags(md) do
    @md_to_html_tags
    |> Enum.reduce(md, fn {md_tag, html_tag}, output -> output |> md_to_html_tags(md_tag, html_tag) end) 
  end 
   
  defp md_to_html_tags(md, md_tag, html_tag) do 
    md 
    |> String.replace_prefix(md_tag, "<#{html_tag}>") 
    |> String.replace_suffix(md_tag, "</#{html_tag}>") 
  end 
  
  end
