defmodule Ben.Day02Test do
  use ExUnit.Case, async: true

  alias Ben.Day02
  doctest Day02, import: true

  @test_data "priv/data/ben/day_02_data.txt"

  describe "Part 1" do
    test "should return an integer indicating the sum of all the invalid IDs found with a 'mirror' sequence like 1010 or 11 or 858858" do
      assert Day02.part_one(@test_data) == 23_701_357_374
    end
  end

  describe "Part 2" do
    test "should return an integer indicating the sum of all the invalid IDs found with a 'mirror' sequence OR a repeated pattern from beginning to end like 111 or 212121 or 123123123" do
      assert Day02.part_two(@test_data) == 34_284_458_938
    end
  end
end
