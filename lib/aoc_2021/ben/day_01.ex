defmodule Aoc2021.Ben.Day01 do
  @moduledoc """
  --- Day 1: Sonar Sweep ---
  """

  def count_depth_increases(input) do
    input 
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({0, nil}, fn 
      depth, {0, nil} -> {0, depth}
      depth, {count, prev_depth} when depth > prev_depth -> {count + 1, depth}
      depth, {count, _prev_depth} -> {count, depth}
    end)
    |> elem(0)
  end

  def count_depth_increases_by_threes(input) do
    input 
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> compare_groups_of_three()
  end

  defp compare_groups_of_three([a, b, c | t]), do: do_compare([b, c | t], a + b + c, 0)

  defp do_compare([a, b, c | t], previous_three_sum, count) when a + b + c > previous_three_sum, do: do_compare([b, c | t], a + b + c, count + 1)
  defp do_compare([a, b, c | t], _previous_three_sum, count), do: do_compare([b, c | t], a + b + c, count)
  defp do_compare(_, _previous_three_sum, count), do: count
end
