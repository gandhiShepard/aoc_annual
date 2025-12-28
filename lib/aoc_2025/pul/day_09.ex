defmodule Pul.Day09 do

  def largest_rectangle_between(tile_positions = %Stream{}),
    do:
      tile_positions
      |> Enum.map(&tile/1)
      |> largest_rectangle_between(0)

  defp tile(tile) when is_binary(tile) do
    [x, y] = String.split(tile, ",")
    {String.to_integer(x), String.to_integer(y)}
  end

  defp largest_rectangle_between(tile_positions, max)
  defp largest_rectangle_between([t1 | other_tiles], max),
    do: largest_rectangle_between(other_tiles,
          (for t2 <- other_tiles, reduce: max do
            max_area -> max(max_area, area(t1, t2))
          end))
  defp largest_rectangle_between([], max), do: max

  defp area({x1, y1}, {x2, y2}), do: (abs(x2-x1)+1) * (abs(y2-y1)+1)
end
