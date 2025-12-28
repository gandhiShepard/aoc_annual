defmodule Pul.Day04 do

  def count_of_accessible_paper_rolls(grid_rows = %Stream{}),
    do:
      with(
        paper_rolls = paper_rolls(grid_rows),
        do: Enum.count(paper_rolls, &accessible?(&1, paper_rolls)))

  defp paper_rolls(grid_rows = %Stream{}),
    do:
      grid_rows
      |> Stream.with_index(0)
      |> Enum.reduce(MapSet.new(), fn {row, r}, paper_rolls when is_binary(row) and is_integer(r)->
        for({?@, c} <- to_charlist(row) |> Enum.with_index(0), into: paper_rolls, do: {r, c})
      end)

  defp accessible?({r, c}, paper_rolls = %MapSet{}),
    do:
      (for dr <- -1..1, dc <- -1..1, not(dr == 0 and dc == 0), MapSet.member?(paper_rolls, {r + dr, c + dc}), reduce: 0 do
        neighbour_rolls -> neighbour_rolls + 1
      end) < 4

  def count_of_removable_paper_rolls(grid_rows = %Stream{}),
    do:
      with(
        paper_rolls = paper_rolls(grid_rows),
        remaining_paper_rolls = remove_all_accessible_paper_rolls(paper_rolls),
        do: Enum.count(paper_rolls) - Enum.count(remaining_paper_rolls))

  defp remove_all_accessible_paper_rolls(paper_rolls = %MapSet{}),
    do:
      (case (for paper_roll <- paper_rolls, !accessible?(paper_roll, paper_rolls), into: MapSet.new(), do: paper_roll) do
        ^paper_rolls -> paper_rolls
        remaining_paper_rolls -> remove_all_accessible_paper_rolls(remaining_paper_rolls)
      end)

end
