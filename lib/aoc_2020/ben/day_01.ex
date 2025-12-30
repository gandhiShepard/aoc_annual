defmodule Aoc2020.Ben.Day01 do
  @moduledoc """
  --- Day 1: Report Repair ---
  """

  def expense_report_processor(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_two_entries_that_sum_equals_2020()
    |> Enum.product()
  end

  defp find_two_entries_that_sum_equals_2020(list), do: do_find(list)

  defp do_find([h | t]), do: do_find(t, t, h)
  defp do_find([h | _t], _reuse, current) when current + h == 2020, do: [current, h] 
  defp do_find([_h | t], reuse, current), do: do_find(t, reuse, current) 
  defp do_find([], [h | reuse], _current), do: do_find(reuse, reuse, h) 

  def expense_report_processor_next(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> find_three_entries_that_sum_equals_2020()
    # |> do_find_three()
    # |> brute_find()
    # |> hd()
    |> Enum.product()
  end

  # defp brute_find(list) do
  #   for a <- list, b <- list, c <- list, a + b + c == 2020, do: [a, b, c]
  # end

  defp find_three_entries_that_sum_equals_2020(list), do: do_find_three(list)

  # init
  defp do_find_three([h | t]), do: do_find_three(t, [], t, h)

  # repeat - full reset - when this matches, we have exhausted our search with the given list, start over from snapshot
  defp do_find_three([_a, _b], [], snapshot, _c), do: do_find_three(snapshot)
  # repeat - recycle - when this matches, we need to keep trying with the recycled data against "c"
  defp do_find_three([_a], recycle, snapshot, c), do: do_find_three(recycle, [], snapshot, c)
  # stop - three numbers found in list whose sum == 2020
  defp do_find_three([a, b | _t], _recycle, _snapshot, c) when a + b + c  == 2020, do: [a, b, c]

  # repeat - no match - keep "a" in head position, append "b" to recycle
  defp do_find_three([a, b | t], recycle, snapshot, c), do: do_find_three([a | t], [b | recycle], snapshot, c)

end
