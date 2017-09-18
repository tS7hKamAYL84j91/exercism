defmodule Markdown do
  @md_to_html_tags [
    {"# ", "h1"},
    {"## ", "h2"},
    {"### ", "h3"},
    {"#### ", "h4"},
    {"##### ", "h5"},
    {"###### ", "h6"},
    {"* ","li"},
    {"", "p"}]

  @md_to_html_inline_tags [
    {"__", "strong"}, 
    {"_", "em"}]

  @enclose_tag ""
  @html_list_tag "<li>"
  @html_unorder_list_tag "ul"


  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(md) do 
    md 
    |> String.split("\n") # Split Md into seperate lines
    |> Enum.map(&parse_line/1) # Parse each line
    |> Enum.chunk_by(&String.starts_with?(&1,@html_list_tag)) # Chunk resulting Html into blocks of lists and other
    |> Enum.map(&Enum.join(&1)) # Join resulting blocks of text ready for final processing
    |> Enum.map_join(&parse_list/1)  # Parse and join the blocks
  end
  
  # Create function from the @md_to_html_tags list
  for {md_tag, html_tag} <- @md_to_html_tags do
    defp parse_line(unquote(md_tag) <> md), do: md |> parse_line(unquote(html_tag)) 
  end 
  
  # Processing of markdown line based on output of parse_line/1
  defp parse_line(md, html_tag) do 
    md 
    |> String.split # Split into words 
    |> Enum.map_join(" ", &md_to_html_inline_tags/1) # replace any inline tags
    |> md_to_html_tags(@enclose_tag, html_tag) # enclose the resulting line with html_tag
  end

  # Replacement of hack in original code to wrap list blocks in an unordered list tag
  def parse_list(@html_list_tag <> _ = html), do:  html |> md_to_html_tags(@enclose_tag, @html_unorder_list_tag)
  def parse_list(html), do:  html

  # Helper function that replaces inline md tags with html
  defp md_to_html_inline_tags(md) do
    @md_to_html_inline_tags # Use data structure to drive replacement of inline tags
    |> Enum.reduce(md, fn {md_tag, html_tag}, output -> output |> md_to_html_tags(md_tag, html_tag) end) 
  end 
   
  defp md_to_html_tags(md, md_tag, html_tag) do 
    md 
    |> String.replace_prefix(md_tag, "<#{html_tag}>") 
    |> String.replace_suffix(md_tag, "</#{html_tag}>") 
  end 
  
  end
