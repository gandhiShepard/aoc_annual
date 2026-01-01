defmodule Aoc2017.Ben.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2017.Ben.Day02

  describe "checksum_one/1" do
    test "should return integer indicating the correct checksum" do
      data = """
      5 1 9 5
      7 5 3
      2 4 6 8
      """

      test_data = "./test/aoc_2017/ben/data/day_02" |> File.read!()

      assert Day02.checksum_one(data) == 18
      assert Day02.checksum_one(test_data) == 53460
    end
  end

  describe "checksum_two/1" do
    test "should return integer indicating the correct checksum" do
      data = """
      5 9 2 8
      9 4 7 3
      3 8 6 5
      """

      test_data = "./test/aoc_2017/ben/data/day_02" |> File.read!()

      assert Day02.checksum_two(data) == 9
      assert Day02.checksum_two(test_data) == 282
    end
  end

end
