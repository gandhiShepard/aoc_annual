defmodule Aoc2021.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2021.Ben.Day01

  describe "count_depth_increases/1" do
    test "ok" do
      data = """
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
      """
      assert Day01.count_depth_increases(data) == 7

      test_data = "./test/aoc_2021/ben/data/day_01" |> File.read!()

      assert Day01.count_depth_increases(test_data) == 1374
    end
  end

  describe "count_depth_increases_by_threes/1" do
    test "ok" do
      data = """
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
      """
      assert Day01.count_depth_increases_by_threes(data) == 5

      test_data = "./test/aoc_2021/ben/data/day_01" |> File.read!()

      assert Day01.count_depth_increases_by_threes(test_data) == 1418
    end
  end

end
