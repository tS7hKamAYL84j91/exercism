defmodule Graph do
  defstruct attrs: [], nodes: [], edges: []
end

defmodule Dot do

  defmacro graph(graph_dsl), do: graph_dsl |> parse_graph_dsl |> Enum.reduce(%Graph{}, &dsl_to_struct/2) |> prepare_response
  
  # The ast comes in two forms depending on the number of elements in the do block
  defp parse_graph_dsl([do: {:__block__, _, ls}]), do: ls  # 0, or many elements
  defp parse_graph_dsl([do: l]), do: [l] # 1 element

  # Reduce valid ast lines to %Graph{} and create :error for the rest
  defp dsl_to_struct({:graph,  _, [[]]}, g), do: g
  defp dsl_to_struct({:graph, _, [[kv]]}, %Graph{attrs: as}=g), do: %Graph{ g | attrs: [kv|as] }
  defp dsl_to_struct({:--, _, [{node1, _, _}, {node2, _, [kvs]}]}, %Graph{edges: es}=g), do: %Graph{ g | edges: [{node1, node2, kvs}|es] }
  defp dsl_to_struct({:--, _, [{node1, _, _}, {node2, _, nil}]}, %Graph{edges: es}=g), do: %Graph{ g | edges: [{node1, node2,  []}|es] }
  defp dsl_to_struct({node, _, [[{k,v}]]}, %Graph{nodes: ns}=g), do: %Graph{ g | nodes: ns |> Keyword.update(node, [{k,v}], &Keywords.put(&1,k,v) )}
  defp dsl_to_struct({node, _, [[]]}, %Graph{nodes: ns}=g), do: %Graph{ g | nodes: ns |> Keyword.update(node, [], &(&1))}
  defp dsl_to_struct({node, _, nil}, %Graph{nodes: ns}=g), do: %Graph{ g | nodes: ns |> Keyword.update(node, [], &(&1))}
  defp dsl_to_struct(_,_), do: :error

  defp prepare_response(:error), do: raise ArgumentError
  defp prepare_response(g), do: %Graph{attrs: Enum.sort(g.attrs), nodes: Enum.sort(g.nodes), edges: Enum.sort(g.edges)} |> Macro.escape

end


