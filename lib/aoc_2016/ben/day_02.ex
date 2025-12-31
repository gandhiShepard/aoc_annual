defmodule Aoc2016.Ben.Day02 do
  @moduledoc """
  --- Day 2: Bathroom Security ---
  """

  def bathroom_decoder(input) do
    input
    |> String.split()
    |> Enum.reduce({"5", ""}, &decode/2)
    |> elem(1)
    |> String.to_integer()
  end

  @decoder %{
    {"U", "1"} => "1", {"U", "2"} => "2", {"U", "3"} => "3", {"U", "4"} => "1", {"U", "5"} => "2",
    {"U", "6"} => "3", {"U", "7"} => "4", {"U", "8"} => "5", {"U", "9"} => "6", {"D", "1"} => "4",
    {"D", "2"} => "5", {"D", "3"} => "6", {"D", "4"} => "7", {"D", "5"} => "8", {"D", "6"} => "9",
    {"D", "7"} => "7", {"D", "8"} => "8", {"D", "9"} => "9", {"L", "1"} => "1", {"L", "2"} => "1",
    {"L", "3"} => "2", {"L", "4"} => "4", {"L", "5"} => "4", {"L", "6"} => "5", {"L", "7"} => "7",
    {"L", "8"} => "7", {"L", "9"} => "8", {"R", "1"} => "2", {"R", "2"} => "3", {"R", "3"} => "3",
    {"R", "4"} => "5", {"R", "5"} => "6", {"R", "6"} => "6", {"R", "7"} => "8", {"R", "8"} => "9",
    {"R", "9"} => "9"
  }

  defp decode("", {position, code}), do: {position, code <> position}

  for {{direction, position}, next_position} <- @decoder,
      do:
        defp(decode(unquote(direction) <> rest, {unquote(position), code}),
          do: decode(rest, {unquote(next_position), code})
        )

  def real_bathroom_decoder(input) do
    input
    |> String.split()
    |> Enum.reduce({"5", ""}, &real_decode/2)
    |> elem(1)
  end

  @real_decoder %{
    {"U", "1"} => "1", {"U", "2"} => "2", {"U", "3"} => "1", {"U", "4"} => "4", {"U", "5"} => "5", {"U", "6"} => "2", {"U", "7"} => "3",
    {"U", "8"} => "4", {"U", "9"} => "9", {"U", "A"} => "6", {"U", "B"} => "7", {"U", "C"} => "8", {"U", "D"} => "B", {"D", "1"} => "3",
    {"D", "2"} => "6", {"D", "3"} => "7", {"D", "4"} => "8", {"D", "5"} => "5", {"D", "6"} => "A", {"D", "7"} => "B", {"D", "8"} => "C",
    {"D", "9"} => "9", {"D", "A"} => "A", {"D", "B"} => "D", {"D", "C"} => "C", {"D", "D"} => "D", {"L", "1"} => "1", {"L", "2"} => "2",
    {"L", "3"} => "2", {"L", "4"} => "3", {"L", "5"} => "5", {"L", "6"} => "5", {"L", "7"} => "6", {"L", "8"} => "7", {"L", "9"} => "8",
    {"L", "A"} => "A", {"L", "B"} => "A", {"L", "C"} => "B", {"L", "D"} => "D", {"R", "1"} => "1", {"R", "2"} => "3", {"R", "3"} => "4",
    {"R", "4"} => "4", {"R", "5"} => "6", {"R", "6"} => "7", {"R", "7"} => "8", {"R", "8"} => "9", {"R", "9"} => "9", {"R", "A"} => "B",
    {"R", "B"} => "C", {"R", "C"} => "C", {"R", "D"} => "D"
  }

  defp real_decode("", {position, code}), do: {position, code <> position}

  for {{direction, position}, next_position} <- @real_decoder,
      do:
        defp(real_decode(unquote(direction) <> rest, {unquote(position), code}),
          do: real_decode(rest, {unquote(next_position), code})
        )
end
