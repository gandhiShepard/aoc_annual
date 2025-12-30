defmodule Aoc2022.Ben.DayOneTest do
  use ExUnit.Case, async: true

  alias Aoc2022.Ben.DayOne

  describe "elf_with_most_calories/1" do
    test "should return an integer representing the largest calorie sublist in the input" do
      data = """
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
      """

      test_data = "./test/aoc_2022/ben/data/day_01" |> File.read!()

      assert DayOne.elf_with_most_calories(data) == 24000
      assert DayOne.elf_with_most_calories(test_data) == 72240
    end
  end

  describe "top_three_elves_with_most_calories/1" do
    test "should return an integer representing the largest calorie sublist in the input" do
      data = """
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
      """

      test_data = "./test/aoc_2022/ben/data/day_01" |> File.read!()

      assert DayOne.top_three_elves_with_most_calories(data) == 45000
      assert DayOne.top_three_elves_with_most_calories(test_data) == 210957
    end
  end
end
