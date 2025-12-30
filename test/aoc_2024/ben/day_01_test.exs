defmodule Aoc2024.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2024.Ben.Day01

  describe "total_distance_between_lists/1" do
    test "should return an integer indication the total distance between lists" do
      data = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

      test_data = "./test/aoc_2024/ben/data/day_01" |> File.read!()

      assert Day01.total_distance_between_lists(data) == 11
      assert Day01.total_distance_between_lists(test_data) == 1666427
    end
  end

  describe "similarity_score/1" do
    test "should return an integer indication the total distance between lists" do
      data = """
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
      """

      test_data = "./test/aoc_2024/ben/data/day_01" |> File.read!()

      assert Day01.similarity_score(data) == 31
      assert Day01.similarity_score(test_data) == 24316233
    end
  end

end
