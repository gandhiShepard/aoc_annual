defmodule Aoc2018.Ben.Day01 do
  @moduledoc """
  --- Day 1: Chronal Calibration --- 
  """
  def frequencify(input), 
    do:
    input
    |> format_data()
    |> Enum.sum()

  def first_repeated_frequency(input),
    do:
    input
    |> format_data()
    |> recycle_data_until_found()

  defp recycle_data_until_found(input), do: do_find(input, input, 0, %{})
  defp do_find([_h | _t], _input, freq, seen) when is_map_key(seen, freq), do: freq
  defp do_find([h | t], input, freq, seen), do: do_find(t, input, freq + h, Map.update(seen, freq, 0, & &1 + 1))
  defp do_find([], input, freq, seen), do: do_find(input, input, freq, seen)

  defp format_data(input),
    do:
    input
    |> String.split()
    |> Enum.map(fn 
      "+" <> number -> String.to_integer(number)
      "-" <> number -> -String.to_integer(number)
    end)
end
