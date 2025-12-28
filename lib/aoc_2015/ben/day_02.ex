defmodule Aoc2015.Ben.Day02 do
  def total_square_feet_of_wrapping_paper(input) do
    input
    |> Enum.map(fn s -> String.split(s, "x") |> Enum.map(fn s -> String.to_integer(s) end) end)
    |> Enum.reduce(0, &process_wrapping_paper/2)
  end

  defp process_wrapping_paper([w, h, l] = list, acc), 
    do: with(
      surface_area = 2 * l * w + 2 * w * h + 2 * h * l,
      [smallest, next, _largest] = Enum.sort([w, h, l], :asc),
      area_of_smallest_side = smallest * next,
      do: surface_area + area_of_smallest_side + acc
    )

  def total_feet_of_ribbon_needed(input) do
    input
    |> Enum.map(fn s -> String.split(s, "x") |> Enum.map(fn s -> String.to_integer(s) end) end)
    |> Enum.reduce(0, &process_ribbons/2)
  end

  defp process_ribbons(list, acc), 
    do: with(
      [smallest, next, _largest] = Enum.sort(list, :asc),
      smallest_perimiter = (smallest + next) * 2,
      ribbon_size = Enum.product(list),
      do: smallest_perimiter + ribbon_size + acc
    )

end
