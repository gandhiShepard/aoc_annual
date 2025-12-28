defmodule Ben.Day03Test do
  use ExUnit.Case, async: true

  alias Ben.Day03
  doctest Day03, import: true

  @test_data "priv/data/ben/day_03_data.txt"

  describe "Part 1" do
    test "should return an integer indicating the sum of the TWO batteries with the highest joltage in every line" do
      assert Day03.part_one(@test_data) == 17_383
    end
  end

  describe "Part 2" do
    test "should return an integer indicating the sum of 12 highest batters in every line" do
      assert Day03.part_two(@test_data) == 172601598658203
        # 92_543_596_995_656
    end
  end

end
