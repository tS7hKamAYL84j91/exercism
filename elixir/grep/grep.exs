defmodule Grep do
  import String, only: [upcase: 1]

  @aliases [n: :line_numbers, l: :file_name, v: :inverse, x: :full_line, i: :ignore_case]

  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    files
    |> Enum.map(&grep_file(pattern, ["--num-files", "#{files |> Enum.count()}" | flags], &1))
    |> Enum.join("")
  end

  def grep_file(pattern, flags, file) do
    with opts <- flags |> parse_flags,
         do: file |> read_lines |> filter_lines(pattern, opts) |> format_lines(file, opts)
  end

  def read_lines(file), do: File.stream!(file) |> Stream.with_index(1)

  def parse_flags(flags) do
    OptionParser.parse(flags, aliases: @aliases, switches: [num_files: :integer])
    |> elem(0)
    |> Enum.into(%{})
  end

  def filter_lines(file_stream, pattern, opts),
    do: file_stream |> Stream.filter(&(pattern |> line_filter(opts)).(&1 |> elem(0)))

  def line_filter(pattern, %{inverse: true} = opts),
    do: &(not (pattern |> line_filter(opts |> Map.drop([:inverse]))).(&1))

  def line_filter(pattern, %{ignore_case: true, full_line: true}),
    do: &(upcase(&1) == upcase(pattern) <> "\n")

  def line_filter(pattern, %{ignore_case: true}), do: &(upcase(&1) =~ upcase(pattern))
  def line_filter(pattern, %{full_line: true}), do: &(&1 == pattern <> "\n")
  def line_filter(pattern, _default), do: &(&1 =~ pattern)

  def format_lines(file_stream, file, %{line_numbers: true} = opts) do
    file_stream
    |> Stream.map(fn {line, num} -> "#{num}:" <> line end)
    |> add_file_name(file, opts)
    |> Enum.join("")
  end

  def format_lines(file_stream, file, %{file_name: true}),
    do: file_stream |> Enum.reduce("", fn _, _ -> file <> "\n" end)

  def format_lines(file_stream, file, opts) do
    file_stream
    |> Stream.map(fn {line, _num} -> line end)
    |> add_file_name(file, opts)
    |> Enum.join("")
  end

  def add_file_name(file_stream, file, %{num_files: n}) when n > 1,
    do: file_stream |> Stream.map(&"#{file}:#{&1}")

  def add_file_name(file_stream, _file, _opts), do: file_stream
end
