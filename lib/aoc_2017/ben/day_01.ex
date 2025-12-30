defmodule Aoc2017.Ben.Day01 do
  @moduledoc """
  --- Day 1: Inverse Captcha ---
  """

  def captcha_solver(input), do: do_solve(input)

  defp do_solve([first, first | t]), do: do_solve([first | t], first, first)
  defp do_solve([first | t]), do: do_solve(t, first, 0)

  defp do_solve([first], first, sum), do: sum + first
  defp do_solve([_last], _first, sum), do: sum

  defp do_solve([h, h | t], first, sum), do: do_solve([h | t], first, sum + h)
  defp do_solve([_h | t], first, sum), do: do_solve(t, first, sum)

  def captcha_solver_b(input) do
    input
    |> Enum.split(div(length(input), 2))
    |> then(fn {a, b} -> Enum.zip(a, b) end)
    |> Enum.reduce(0, fn
      {d, d}, acc -> d * 2 + acc
      _, acc -> acc
    end)
  end
end
