defmodule Ben.Day02 do
  @moduledoc ~S"""
  # Gift Shop

  Identify the invalid product IDs
  """

  @doc ~S"""

  ### Example data

  11-22,95-115,998-1012,1188511880-1188511890,222220-222224, 1698522-1698528,446443-446449,38593856-38593862,565653-565659, 824824821-824824827,2121212118-2121212124

  - The ranges are separated by commas (,)
  - each range gives its first ID and last ID separated by a dash (-).

  We return an integer indicating the sum of all the invalid IDs found with a 'mirror' sequence like 1010 or 11 or 858858."

    iex> part_one("priv/data/ben/day_02_example_data.txt")
    1_227_775_554

  """
  @spec part_one(String.t()) :: non_neg_integer
  def part_one("priv/" <> _rest_of_path = path_to_data) do
    path_to_data
    |> stream_input()
    |> Enum.reduce([], fn
      range, acc ->
        [Enum.filter(range, &evenly_repeated_sequence_of_digits?/1) | acc]
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  defp evenly_repeated_sequence_of_digits?(digit) do
    half_digit_length = div(digit_length(digit), 2)
    divisor_and_modulo = trunc(:math.pow(10, half_digit_length))

    digit_of_even_length?(digit) &&
      div(digit, divisor_and_modulo) == rem(digit, divisor_and_modulo)
  end

  defp digit_of_even_length?(digit), do: rem(digit_length(digit), 2) == 0
  defp digit_length(digit), do: trunc(:math.log10(digit) + 1)

  # ------------------------------------------------------------------------------
  @doc ~S"""
  Now, an ID is invalid if it is made only of some sequence of digits repeated at least twice. So, 12341234 (1234 two times), 123123123 (123 three times), 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.

    iex> part_two("priv/data/ben/day_02_example_data.txt")
    4_174_379_265
  """
  @spec part_two(String.t()) :: non_neg_integer
  def part_two("priv/" <> _rest_of_path = path_to_data) do
    path_to_data
    |> stream_input()
    |> Enum.reduce([], fn
      range, acc ->
        [Enum.filter(range, &evenly_repeated_or_entirely_repeated_sequence_of_digits?/1) | acc]
    end)
    |> List.flatten()
    |> Enum.sum()
  end

  defp evenly_repeated_or_entirely_repeated_sequence_of_digits?(digit),
    do: evenly_repeated_sequence_of_digits?(digit) || repeated_sequence_of_digits?(digit)

  defp repeated_sequence_of_digits?(digit),
    do:
      digit
      |> Integer.to_string()
      # Starts with any number except 0
      # Has a repeating pattern of digits from [0-9]
      # Must end in a digit
      |> String.match?(~r/^([1-9]+[0-9]*)\1+$/)

  # ------------------------------------------------------------------------------

  defp stream_input(input) do
    File.read!(input)
    |> String.trim()
    |> Stream.unfold(&next_word/1)
    |> Stream.map(&String.split(&1, "-"))
    |> Stream.map(fn [left, right] -> String.to_integer(left)..String.to_integer(right) end)
  end

  # The next_function for Stream.unfold
  defp next_word("") do
    # When the accumulator (remaining string) is empty, stop the stream
    nil
  end

  defp next_word(remaining_string) do
    case String.split(remaining_string, ",", parts: 2) do
      [word, rest] ->
        # Yield the word, and use the 'rest' as the next accumulator
        {word, rest}

      [word] ->
        # Yield the final word, and use an empty string "" as the next accumulator
        # which will cause the next call to return nil and stop the stream.
        {word, ""}
    end
  end
end
