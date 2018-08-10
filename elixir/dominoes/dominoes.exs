defmodule Dominoes do
  require Integer

  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain

  We treat the dominos as edges in a graph see https://www.pagat.com/tile/wdom/math.html
  and use graph theroy & Euler's "Bridges of Königsberg problem"
  """
  @spec chain?(dominoes :: [domino] | []) :: boolean
  def chain?([]), do: true

  def chain?(dominoes),
    do: dominos_graph_is_connected(dominoes) and dominos_graph_vertices_even_degree(dominoes)

  def dominos_graph_is_connected(dominoes), do: dominoes |> Graph.new() |> Graph.is_connected()

  def dominos_graph_vertices_even_degree(dominoes) do
    dominoes
    |> Graph.new()
    |> Graph.degree_of_each_vertex()
    |> Enum.filter(&(rem(elem(&1, 1), 2) != 0))
    |> length
    |> Kernel.==(0)
  end
end

defmodule Graph do
  def new(edges), do: adjency_list(edges |> to_verticies, edges)

  defp to_verticies(edges),
    do: edges |> Enum.flat_map(fn {a, b} -> [a, b] end) |> Enum.sort() |> Enum.dedup()

  def adjency_list(vertices, edges) do
    vertices
    |> Enum.map(&incident_edges(&1, edges))
    |> Enum.zip(vertices)
    |> Enum.map(&adjacent_verticies/1)
  end

  def incident_edges(v, edges), do: edges |> Enum.filter(&incident_edge(&1, v))

  defp incident_edge({v, _b}, v), do: true
  defp incident_edge({_a, v}, v), do: true
  defp incident_edge({_, _}, _), do: false

  defp adjacent_verticies({es, v}),
    do: {v, es |> Enum.reduce([], &adjacent_verticies(&1, &2, v)) |> Enum.sort()}

  defp adjacent_verticies({v, v}, acc, v), do: [v | acc]
  defp adjacent_verticies({a, v}, acc, v), do: [a | acc]
  defp adjacent_verticies({v, b}, acc, v), do: [b | acc]

  def is_connected(graph),
    do: graph |> verticies_in_chain_from_head |> length |> Kernel.==(graph |> length)

  defp verticies_in_chain_from_head(graph),
    do: graph |> Graph.bfs(first_vertex(graph)) |> Enum.sort() |> Enum.dedup()

  defp first_vertex(graph), do: graph |> hd |> elem(0)

  def degree_of_each_vertex(graph), do: graph |> Enum.map(&vertex_degree/1)

  defp vertex_degree({v, vs}), do: {v, vs |> Enum.reduce(0, &vertex_degree(&1, &2, v))}

  defp vertex_degree(v, acc, v), do: acc + 2
  defp vertex_degree(_x, acc, _v), do: acc + 1

  # breadth first search for paths in a graph https://en.wikipedia.org/wiki/Breadth-first_search
  def bfs(graph, root), do: bfs([root], [], graph)

  defp bfs([] = _queue, visited, _), do: visited

  defp bfs([q | queue], visited, graph),
    do: bfs(queued_verticies(q, graph, queue, visited), [q | visited], graph)

  defp queued_verticies(current_idx, graph, queue, visited) do
    graph
    |> Enum.find(fn {idx, _} -> idx == current_idx end)
    |> elem(1)
    |> Kernel.--(visited)
    |> Kernel.++(queue)
  end
end
