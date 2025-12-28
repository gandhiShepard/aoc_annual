defmodule Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Ben.Day01
  doctest Day01, import: true

  describe "Part 1" do
    test "should return an integer indicating the total amount of times the dial landed on 0" do
      path_to_data = "priv/data/ben/day_01_data.txt"
      assert Day01.part1(path_to_data) == 1031
    end
  end

  describe "Part 2" do
    test "should return an integer indicating the total amount of times the dial landed on 0 AND also passed by zero on a turn" do
      path_to_data = "priv/data/ben/day_01_data.txt"
      assert Day01.part2(path_to_data) == 5831
    end
  end
end
