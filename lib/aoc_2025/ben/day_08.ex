defmodule Ben.Day08 do
  def product_of_thee_largest_circuts(stream = %Stream{}) do
    list = stream |> process()
    
    # distances = for p <- list, q <- list, lists = [p, q], do: euclidean_distance_3d(lists)
    
    list
    |> apply_euclidean_distance()
    |> Enum.sort(:asc)
    |> group_by_threshold(5.0)
    |> Enum.group_by(fn {k, v} -> v end)
    # |> Enum.reverse()
    # |> Enum.sort_by(&length(&1), :desc)
    # |> Enum.take(3)
    # |> Enum.product_by(&length(&1))
    # |> dbg()
    # |> dbg()
    # |> Enum.reject(&match?(elem, ))
  end

  defp euclidean_distance_3d({p1, p2, p3} = p, {q1, q2, q3} = q), 
    do: {:math.sqrt(:math.pow(p1 - q1, 2) + :math.pow(p2 - q2, 2) + :math.pow(p3 - q3, 2)), {p, q}}

  defp process(stream) do
    stream
    |> Stream.flat_map(&String.split(&1, ","))
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(3)
    |> Stream.map(&List.to_tuple/1)
    |> Enum.to_list()
    # |> Enum.take(2)
    # |> then(&euclidean_distance_3d/1)
  end

  # init
  defp apply_euclidean_distance(list, recycle \\ [], acc \\ [])
  # stop
  defp apply_euclidean_distance([a, b], [], acc), do: [euclidean_distance_3d(a, b) | acc]
  defp apply_euclidean_distance([], [], acc), do: acc
  # # recycle
  # defp apply_euclidean_distance([_used, last], recycle, acc), 
  #   do: apply_euclidean_distance([last | recycle], [], acc)
  # repeat
  defp apply_euclidean_distance([a, b | rest], recycle, acc), do: apply_euclidean_distance([a | rest], [b | recycle], [euclidean_distance_3d(a, b) | acc])
  # recycle
  defp apply_euclidean_distance([_used], recycle, acc), do: apply_euclidean_distance(recycle, [], acc)


  defp group_by_threshold(list, threshold, circut \\ 0, acc \\ %{})
  # defp group_by_threshold([{dist_a, _} = a, {dist_b, _} = b | rest], threshold, [[] | acc])
  #   when abs(dist_a - dist_b) <= threshold, 
  #   do: group_by_threshold([a | rest], threshold, [[b, a] | acc])
  
  defp group_by_threshold([{dist_a, _} = a, {dist_b, coords} | rest], threshold, circut, acc) 
    when abs(dist_a - dist_b) <= threshold, do:
    group_by_threshold([a | rest], threshold, circut, Enum.reduce(Tuple.to_list(coords), acc, fn c, acc -> Map.put_new(acc, c, circut) end))

  # defp group_by_threshold([{dist_a, _} = a, {dist_b, _} = b | rest], threshold, circut, acc) 
  #   when abs(dist_a - dist_b) <= threshold, do:
  #   group_by_threshold([a | rest], threshold, circut, Map.put_new(acc, b, circut))

  defp group_by_threshold([{_dist_a, coords} | rest], threshold, circut, acc), 
    do: group_by_threshold(rest, threshold, circut + 1, Enum.reduce(Tuple.to_list(coords), acc, fn c, acc2 -> Map.put_new(acc2, c, circut) end))

  defp group_by_threshold([], _threshold, _circut, acc), do: acc

  #
  # defp group_by_threshold(list, threshold, acc \\ [[]])
  # # defp group_by_threshold([{dist_a, _} = a, {dist_b, _} = b | rest], threshold, [[] | acc])
  # #   when abs(dist_a - dist_b) <= threshold, 
  # #   do: group_by_threshold([a | rest], threshold, [[b, a] | acc])
  #
  # defp group_by_threshold([{dist_a, _} = a, {dist_b, _} = b | rest], threshold, [head | acc]) 
  #   when abs(dist_a - dist_b) <= threshold, do:
  #   group_by_threshold([a | rest], threshold, [[b | head] | acc])
  #
  # defp group_by_threshold([a | rest], threshold, [head | acc]), 
  #   do: group_by_threshold(rest, threshold, [[], [a | head] | acc])
  #
  # defp group_by_threshold([], _threshold, acc), do: acc
end
