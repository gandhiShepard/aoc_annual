defmodule Aoc2015.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2015.Ben.Day01

  defp test_data, do: File.stream!("./test/aoc_2015/ben/data/day_01", 1)

  describe "2015 Day01 - appartment_floor_instructions_reader/1" do
    test "should return an integer representing the floor to exit on" do
      assert Day01.appartment_floor_instructions_reader(test_data()) == 138
    end

    test "UNIT - should return 1 when only given a (" do
      assert Day01.appartment_floor_instructions_reader(["("]) == 1
    end

    test "UNIT - should return -1 when only given a )" do
      assert Day01.appartment_floor_instructions_reader([")"]) == -1
    end

    test "UNIT - should return 0 when only given a opening and closing parens" do
      assert Day01.appartment_floor_instructions_reader(["(", ")"]) == 0
      assert Day01.appartment_floor_instructions_reader([")", "("]) == 0
    end
  end

  describe "2015 Day01 - first_basement_floor/1" do
    test "should return an integer representing the index of the first basement floor reached in the instrustions" do
      assert Day01.first_basement_floor(test_data()) == 1771
      # 1772 is wrong - too high
    end
  end
end
