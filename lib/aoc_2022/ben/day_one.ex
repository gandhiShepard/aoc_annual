defmodule Aoc2022.Ben.DayOne do
  @moduledoc """

  """

  def elf_with_most_calories(input), 
    do:
    input
    |> total_list_groups()
    |> Enum.max()

  def top_three_elves_with_most_calories(input),
    do:
    input
    |> total_list_groups()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()

  defp total_list_groups(input),
    do:
    input
    |> String.split("\n\n")
    |> Enum.map(fn list -> 
      list
      |> String.split() 
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
end



# defmodule Year2022.Day1 do
#   @moduledoc """
#   Day one, Advent of Code
#
#   The sample data must be split on a double carriage return `\n\n`. This will preserve the grouping of numbers, indicating the caloric items the elves are carrying.
#
#   ## Sample code pattern
#   ```
#   123
#   345
#
#   678
#
#   890
#   ```
#
#   Thus the data gets transformed into `["123\n345", "678\n", "890\n"]`.
#   """
#   defp data do
#     {:ok, data} = File.read("lib/year_2022/day_1.txt")
#
#     data
#     |> String.split("\n\n", trim: true)
#     |> Enum.map(fn x ->
#       x
#       |> String.split("\n", trim: true)
#       |> Enum.map(fn x -> String.to_integer(x) end)
#       |> Enum.sum()
#     end)
#   end
#
#   @doc """
#   72240
#   """
#   def max_cals do
#     data()
#     |> Enum.max()
#   end
#
#   @doc """
#   210957
#   """
#   def top_three_total do
#     data()
#     |> Enum.sort(:desc)
#     |> Enum.take(3)
#     |> Enum.sum()
#   end
# end
#
