defmodule Pul.Day03 do
  def total_output_joltage(battery_banks, number_of_batteries_to_be_used \\ 2),
    do:
      battery_banks
      |> Stream.map(&largest_joltage(&1, number_of_batteries_to_be_used))
      # |> Stream.map(&dbg/1)
      |> Enum.sum()

  def largest_joltage(bank, batteries_to_be_used) when is_binary(bank) when batteries_to_be_used in 1..12,
    do:
      batteries_to_be_used-1..0
      |> Enum.reduce({to_charlist(bank), 0}, fn still_needed_after_this, {available_batteries, joltage} ->

          all_but_still_needed_after_this = Enum.take(available_batteries, Enum.count(available_batteries) - still_needed_after_this)
          max_battery = Enum.max(all_but_still_needed_after_this)

          [^max_battery | still_available_batteries] = Enum.drop_while(available_batteries, & &1 < max_battery)
          joltage = joltage * 10 + (max_battery - ?0)

          {still_available_batteries, joltage}
        end)
      |> then(fn {_still_available_batteries, joltage} -> joltage end)

  # original solution for 2 batteries in part 01 - obsolete, since the one for part 2 is generic
  # def largest_joltage(bank) when is_binary(bank),
  #   do: with(
  #     batteries = [battery_value, _ | _] when battery_value in ?0..?9 <- to_charlist(bank),
  #     all_but_last = Enum.take(batteries, Enum.count(batteries) - 1),
  #     first_battery when first_battery in ?0..?9 <- Enum.max(all_but_last),
  #     [^first_battery | right_of_first] = Enum.drop_while(batteries, & &1 < first_battery),
  #     second_battery when second_battery in ?0..?9 <- Enum.max(right_of_first),
  #     do: 10 * (first_battery - ?0) + (second_battery - ?0))

end
