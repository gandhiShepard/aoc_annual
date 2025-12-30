defmodule Aoc2023.Day01 do
  @moduledoc """
  --- Day 1: Trebuchet?! ---
  """

  def sum_calibration_numbers(input) do
    input
    |> String.split()
    |> Enum.reduce(0, &number_extractor(&1, &2, :numbers))
  end

  def sum_calibration_numbers_and_words(input) do
    input
    |> String.split()
    |> Enum.reduce(0, &number_extractor(&1, &2, :all))
  end

  defp number_extractor(str, acc, type), do: do_extract(str, nil, [], acc, type)

  # defp do_extract(<<d, rest::binary>>, nil, [], acc) when d in ?0..?9, do: do_extract(rest, d - ?0, [], acc)
  # defp do_extract(<<d, rest::binary>>, first, temp, acc) when d in ?0..?9, do: do_extract(rest, first, [d - ?0 | temp], acc)

  # edge cases!
  defp do_extract("oneight" <> rest, nil, [], acc, :all),
    do: do_extract("eight" <> rest, 1, [], acc, :all)

  defp do_extract("oneight" <> rest, first, temp, acc, :all),
    do: do_extract("eight" <> rest, first, [1 | temp], acc, :all)

  defp do_extract("twone" <> rest, nil, [], acc, :all),
    do: do_extract("one" <> rest, 2, [], acc, :all)

  defp do_extract("twone" <> rest, first, temp, acc, :all),
    do: do_extract("one" <> rest, first, [2 | temp], acc, :all)

  defp do_extract("threeight" <> rest, nil, [], acc, :all),
    do: do_extract("eight" <> rest, 3, [], acc, :all)

  defp do_extract("threeight" <> rest, first, temp, acc, :all),
    do: do_extract("eight" <> rest, first, [3 | temp], acc, :all)

  defp do_extract("fiveight" <> rest, nil, [], acc, :all),
    do: do_extract("eight" <> rest, 5, [], acc, :all)

  defp do_extract("fiveight" <> rest, first, temp, acc, :all),
    do: do_extract("eight" <> rest, first, [5 | temp], acc, :all)

  defp do_extract("sevenine" <> rest, nil, [], acc, :all),
    do: do_extract("nine" <> rest, 7, [], acc, :all)

  defp do_extract("sevenine" <> rest, first, temp, acc, :all),
    do: do_extract("nine" <> rest, first, [7 | temp], acc, :all)

  defp do_extract("eightwo" <> rest, nil, [], acc, :all),
    do: do_extract("two" <> rest, 8, [], acc, :all)

  defp do_extract("eightwo" <> rest, first, temp, acc, :all),
    do: do_extract("two" <> rest, first, [8 | temp], acc, :all)

  defp do_extract("eighthree" <> rest, nil, [], acc, :all),
    do: do_extract("three" <> rest, 8, [], acc, :all)

  defp do_extract("eighthree" <> rest, first, temp, acc, :all),
    do: do_extract("three" <> rest, first, [8 | temp], acc, :all)

  defp do_extract("nineight" <> rest, nil, [], acc, :all),
    do: do_extract("eight" <> rest, 9, [], acc, :all)

  defp do_extract("nineight" <> rest, first, temp, acc, :all),
    do: do_extract("eight" <> rest, first, [9 | temp], acc, :all)

  # normal cases
  @numbers Enum.zip(?1..?9, 1..9)
  @number_words Enum.zip(~w[one two three four five six seven eight nine], 1..9)

  for {c, d} <- @numbers,
      do:
        defp(do_extract(<<unquote(c), rest::binary>>, nil, [], acc, type),
          do: do_extract(rest, unquote(d), [], acc, type)
        )

  for {w, d} <- @number_words,
      do:
        defp(do_extract(unquote(w) <> rest, nil, [], acc, :all),
          do: do_extract(rest, unquote(d), [], acc, :all)
        )

  for {c, d} <- @numbers,
      do:
        defp(do_extract(<<unquote(c), rest::binary>>, first, temp, acc, type),
          do: do_extract(rest, first, [unquote(d) | temp], acc, type)
        )

  for {w, d} <- @number_words,
      do:
        defp(do_extract(unquote(w) <> rest, first, temp, acc, :all),
          do: do_extract(rest, first, [unquote(d) | temp], acc, :all)
        )

  defp do_extract(<<_d>> <> rest, first, temp, acc, type),
    do: do_extract(rest, first, temp, acc, type)

  defp do_extract(<<>>, first, [], acc, _type), do: first * 10 + first + acc
  defp do_extract(<<>>, first, [last | _temp], acc, _type), do: first * 10 + last + acc
end
