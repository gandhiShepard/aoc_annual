defmodule Aoc2019.Ben.Day01 do
  @moduledoc ~S"""
  --- Day 1: The Tyranny of the Rocket Equation ---
  """
  def total_fuel_requirement(input) do
    input
    |> Enum.map(fn x -> String.to_integer(x) |> fuel_equation() end)
    |> Enum.sum()
  end

  def additional_total_fuel_requirement(input) do
    input
    |> Enum.map(fn x -> String.to_integer(x) |> additional_fuel() end)
    |> Enum.sum()
  end

  defp additional_fuel(fuel), do: additional_fuel(fuel, 0)
  defp additional_fuel(fuel, acc) when div(fuel, 3) - 2 <= 0, do: acc 
  defp additional_fuel(fuel, acc), do: additional_fuel(fuel_equation(fuel), fuel_equation(fuel) + acc) 

  defp fuel_equation(number), do: div(number, 3) - 2
end
