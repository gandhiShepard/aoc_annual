defmodule Aoc2019.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2019.Ben.Day01

  defp test_data, do: "./test/aoc_2019/ben/data/day_01" |> File.stream!() |> Stream.map(&String.trim/1)

  describe "total_fuel_requirement/1" do
    test "should return integer representing the sum of fuel needed" do
      assert Day01.total_fuel_requirement(["12"]) == 2
      assert Day01.total_fuel_requirement(["14"]) == 2
      assert Day01.total_fuel_requirement(["1969"]) == 654
      assert Day01.total_fuel_requirement(["100756"]) == 33583

      assert Day01.total_fuel_requirement(test_data()) == 3382136
    end
  end

  describe "additional_total_fuel_requirement/1" do
    test "should return integer representing the additional sum of fuel needed" do
      # assert Day01.additional_total_fuel_requirement(["12"]) == 2
      assert Day01.additional_total_fuel_requirement(["14"]) == 2
      assert Day01.additional_total_fuel_requirement(["1969"]) == 966
      assert Day01.additional_total_fuel_requirement(["100756"]) == 50346

      assert Day01.additional_total_fuel_requirement(test_data()) == 5070314
    end
  end

end
