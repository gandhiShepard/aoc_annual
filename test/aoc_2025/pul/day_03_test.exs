defmodule Pul.Day01Test do
  use ExUnit.Case, async: true
  alias Pul.Day03
  doctest Day03, import: true

  defp testsample, do: File.stream!("./test/pul/data/03_01_unit") |> Stream.map(&String.trim/1)
  defp testdata, do: File.stream!("./test/pul/data/03_01") |> Stream.map(&String.trim/1)

  describe "largest_joltage/1" do
    test "detects 2 acending batteries" do
      assert Day03.largest_joltage("987654321111111", 2) == 98
    end
    test "doesn't eat up last as first" do
      assert Day03.largest_joltage("811111111111119", 2) == 89
    end
    test "detects the last two" do
      assert Day03.largest_joltage("234234234234278", 2) == 78
    end
    test "can't be fooled into taking something smaller" do
      assert Day03.largest_joltage("818181911112111", 2) == 92
    end
    test "finds 12 batteries" do
      assert Day03.largest_joltage("987654321111111", 12) == 987654321111
    end
    test "finds the max at the end for 12" do
      assert Day03.largest_joltage("811111111111119", 12) == 811111111119
    end
  end


  describe "Day 03, part 01" do
    test "works with example" do
      assert Day03.total_output_joltage(testsample()) == 357
    end
    test "works with test data" do
      assert Day03.total_output_joltage(testdata()) == 17100
    end
  end
  describe "Day 03, part 02" do
    test "works with example" do
      assert Day03.total_output_joltage(testsample(), 12) == 3121910778619
    end
    test "works with test data" do
      assert Day03.total_output_joltage(testdata(), 12) == 170418192256861
    end
  end
end
