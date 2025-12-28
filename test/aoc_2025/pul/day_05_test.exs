defmodule Pul.Day05Test do
  use ExUnit.Case, async: true
  alias Pul.Day05
  doctest Day05, import: true

  defp testsample, do: File.stream!("./test/pul/data/05_01_unit") |> Stream.map(&String.trim/1)
  defp testdata, do: File.stream!("./test/pul/data/05_01") |> Stream.map(&String.trim/1)

  describe "Day05.merge_ranges(ranges = [%Range{} | _])" do
    test "single range" do
      assert Day05.merge_ranges([6..8]) == [6..8]
    end
    test "2 ranges, no intersection" do
      assert Day05.merge_ranges([1..3, 6..8]) == [1..3, 6..8]
    end
    test "2 ranges, no intersection no gap" do
      assert Day05.merge_ranges([11..15, 16..20]) == [11..20]
    end
    test "3 ranges, no intersection" do
      assert Day05.merge_ranges([1..3, 6..8, 11..20]) == [1..3, 6..8, 11..20]
    end
    test "merging a smaller one doesn't shrink the bigger one" do
      assert Day05.merge_ranges([1..8, 3..6]) == [1..8]
    end
    test "unsorted ranges, multiple intersection" do
      assert Day05.merge_ranges([1..13, 35..60, 717..750, 24..37, 11..19, 8..15]) == [1..19, 24..60, 717..750]
    end
    test "multiple ranges, pairwise intersections" do
      ranges = for(t <- 0..9, s=t * 10, e=s+14, do: s..e)
      assert Day05.merge_ranges(ranges) == [0..104]
    end
    test "multiple ranges, multiple intersections" do
      ranges = for(t <- 0..9, s=t * 10, e=s+84, do: s..e)
      assert Day05.merge_ranges(ranges) == [0..174]
    end
  end
  describe "Day 05, part 01" do
    test "works with example" do
      assert Day05.count_of_available_fresh_ingredients(testsample()) == 3
    end
    test "works with test data" do
      assert Day05.count_of_available_fresh_ingredients(testdata()) == 505
    end
  end
  describe "Day 05, part 02" do
    test "works with example" do
      assert Day05.count_of_fresh_ingredients(testsample()) == 14
    end
    test "works with test data" do
      assert Day05.count_of_fresh_ingredients(testdata()) == 344423158480189
    end
  end
end
