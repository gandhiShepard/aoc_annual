defmodule Ben.Day03 do
  @moduledoc ~S"""
  # Lobby

  Find maximum Joltage
  """

  @doc ~S"""

  ### Example data

  987654321111111
  811111111111119
  234234234234278
  818181911112111

  - Each line of digits in your input corresponds to a single bank of batteries.
  - Within each bank, you need to turn on exactly two batteries
  - the joltage that the bank produces is equal to the number formed by the digits on the batteries you've turned on.
  - For example, if you have a bank like 12345 and you turn on batteries 2 and 4, the bank would produce 24 jolts. (You cannot rearrange batteries.)
  - You'll need to find the largest possible joltage each bank can produce.
  - The total output joltage is the sum of the maximum joltage from each bank, so in this example, the total output joltage is 98 + 89 + 78 + 92 = 357.

  We return an integer indicating the sum of all the mazimum joltage from each bank.

    iex> part_one("priv/data/ben/day_03_example_data.txt")
    357

  """

  @spec part_one(String.t()) :: non_neg_integer
  def part_one("priv/" <> _rest_of_path = path_to_data) do
    path_to_data
    |> stream_input()
    |> Enum.map(&take_n_max_batteries_from_bank_in_order(&1, 2))
    |> Enum.reduce(0, fn number_string, acc -> String.to_integer(number_string) + acc end)
  end

  # ------------------------------------------------------------------------------
  @doc ~S"""
  Now, you need to make the largest joltage by turning on exactly twelve batteries within each bank.

    iex> part_two("priv/data/ben/day_03_example_data.txt")
    3_121_910_778_619
  """
  @spec part_two(String.t()) :: non_neg_integer
  def part_two("priv/" <> _rest_of_path = path_to_data) do
    path_to_data
    |> stream_input()
    |> Enum.map(&take_n_max_batteries_from_bank_in_order(&1, 12))
    |> Enum.reduce(0, fn number_string, acc -> String.to_integer(number_string) + acc end)
  end

  def take_n_max_batteries_from_bank_in_order(line, take), do: do_find(line, take)

  # initalize do_find_12/1
  defp do_find(line, take) do
    <<bank::binary-size(byte_size(line) - take + 1), buffer::binary>> = line
    do_find(bank, buffer, take)
  end

  @reset ""

  defp do_find(bank, buffer, take, rest \\ "", max \\ "", collected \\ "")
  defp do_find(_, _, take, _, _, collected) when byte_size(collected) == take, do: collected
  defp do_find(<<b>> <> bank, buffer, take, max, _rest, collected) when <<b>> > max, do: do_find(bank, buffer, take, <<b>>, @reset, collected)
  defp do_find(<<b>> <> bank, buffer, take, max, rest, collected), do: do_find(bank, buffer, take, max, rest <> <<b>>, collected)
  defp do_find("", "", take, max, seen, collected), do: do_find(seen, @reset, take, @reset, @reset, collected <> max)
  defp do_find("", <<b>> <> buffer, take, max, seen, collected), do: do_find(seen <> <<b>>, buffer, take, @reset, @reset, collected <> max)

  # ------------------------------------------------------------------------------

  defp stream_input(input) do
    input
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
end
