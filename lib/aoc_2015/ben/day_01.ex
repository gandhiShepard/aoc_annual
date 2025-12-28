defmodule Aoc2015.Ben.Day01 do
  @moduledoc ~S"""
  --- Day 1: Not Quite Lisp ---
  """

  def appartment_floor_instructions_reader(input),
    do: Enum.reduce(input, 0,
      fn "\n", acc -> acc
        "(", acc -> acc + 1
        ")", acc -> acc - 1
      end)

  def first_basement_floor(input),
    do: Enum.reduce_while(input, {0, 1}, &process_floors/2)

  # when the current char is ")" and the accumulator indicates floor 0
  # we know that this is the floor, when processed would return a floor of -1
  defp process_floors(")", {0, index}), do: {:halt, index}
  defp process_floors(")", {floor, index}), do: {:cont, {floor - 1, index + 1}}
  defp process_floors("(", {floor, index}), do: {:cont, {floor + 1, index + 1}}
  defp process_floors("\n", acc), do: {:cont, acc}
end
