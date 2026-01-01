defmodule Aoc2017.Ben.Day02 do
  @moduledoc """
  --- Day 2: Corruption Checksum ---
  """

  def checksum_one(input), 
    do:
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line) |> Enum.map(&String.to_integer/1) end)
      |> Enum.reduce(0, &min_max_difference/2) 

  def checksum_two(input),
    do:
      input 
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line) |> Enum.map(&String.to_integer/1) |> Enum.sort(:desc) end)
      |> Enum.reduce(0, &evenly_divisible_values/2)

  defp min_max_difference([n | rest], acc), do: do_difference(rest, n, n, acc)
  defp do_difference([n | rest], min, max, acc) when n > max, do: do_difference(rest, min, n, acc)
  defp do_difference([n | rest], min, max, acc) when n < min, do: do_difference(rest, n, max, acc)
  defp do_difference([_n | rest], min, max, acc), do: do_difference(rest, min, max, acc)
  defp do_difference([], min, max, acc), do: max - min + acc

  defp evenly_divisible_values([max | rest], acc), do: do_divisible(rest, rest, max, acc)
  defp do_divisible([next | _rest], _snapshot, max, acc) when rem(max, next) == 0, do: div(max, next) + acc
  defp do_divisible([_next | rest], snapshot, max, acc), do: do_divisible(rest, snapshot, max, acc)
  defp do_divisible([], snapshot, _max, acc), do: evenly_divisible_values(snapshot, acc)

end
