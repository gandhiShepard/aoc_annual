defmodule Ben.Day04 do
  use Agent

  @moduledoc ~S"""
  # Printing Department
  """

  @doc ~S"""
  The rolls of paper (@) are arranged on a large grid; the Elves even have a helpful diagram (your puzzle input) indicating where everything is located.

  ## Example
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  @directions [
    {-1, 0}, # north
    {-1, 1}, # north_east
    {0, 1},  # east
    {1, 1},  # south_east
    {1, 0},  # south
    {1, -1}, # south_west
    {0, -1}, # west
    {-1, -1} # north_west
  ]

  # @spec part_one(String.t()) :: non_neg_integer
  def part_one(input) do
    grid = input
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(fn x -> String.split(x, "") end)
    |> make_grid()

    adjacent_roll_positions(grid)
    |> then(fn {_, rolls_found} -> Enum.count(rolls_found) end)
    # |> Enum.count()
  end

  def part_two(input) do
    grid = input
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(fn x -> String.split(x, "") end)
    |> make_grid()

    count_removable_rolls(grid, 0)

  end

  defp count_removable_rolls(grid, acc) do
    {grid, rolls_found} = adjacent_roll_positions(grid)
    count = Enum.count(rolls_found)
    updated_grid = remove_rolls(rolls_found, grid)

    case count do
      0 -> acc
      num -> count_removable_rolls(updated_grid, acc + num)
    end
  end

  defp remove_rolls([{{y, x}, _} | rest], grid),
    do: remove_rolls(rest, Map.update(grid, {y, x}, ".", fn _ -> "." end))

  defp remove_rolls([], grid), do: grid

  defp adjacent_roll_positions(grid) do

    roll_positions = Enum.reduce(grid, [], fn
      {{y, x}, "@"} = _coordinate, acc ->
        adjacent_rolls =
          @directions
          |> Enum.map(fn {yy, xx} -> Map.get(grid, {y + yy, x + xx}) end)
          |> Enum.count(& &1 == "@")

        [ {{y, x}, adjacent_rolls}
        | acc]
      _, acc -> acc
    end)
    |> Enum.reject(fn {_, count} -> count > 3 end)

    {grid, roll_positions}
  end

  defp make_grid(input) do
    for {row, i} <- Enum.with_index(input),
        {char, j} <- Enum.with_index(row),
        into: %{},
        do: {{i, j}, char}
  end
end
