defmodule Aoc2024.Ben.Day01 do
  @moduledoc """
  --- Day 1: Historian Hysteria ---
  """

  def total_distance_between_lists(input),
    do:
    input
    |> String.split()
    |> partition()
    |> then(fn {a, b} -> Enum.zip_reduce(a, b, 0, fn x, y, acc -> acc + abs(x - y) end) end)

  def similarity_score(input),
    do:
      with(
        {left_list, right_list} = String.split(input) |> partition(),
        occurance_map = Enum.frequencies(right_list),
        occurance_sum = Enum.reduce(left_list, 0, &Map.get(occurance_map, &1, 0) * &1 + &2),
        do: occurance_sum
      )

  defp partition(list), do: do_part(list, [], [])
  defp do_part([a, b | t], la, lb), do: do_part(t, [String.to_integer(a) | la], [String.to_integer(b) | lb])
  defp do_part([], a, b), do: {Enum.sort(a, :asc), Enum.sort(b, :asc)}
end
