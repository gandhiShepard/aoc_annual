defmodule Aoc2015.Ben.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2015.Ben.Day02

  defp test_data, do: File.stream!("./test/aoc_2015/ben/data/day_02") |> Stream.map(&String.trim(&1))

  describe "total_square_feet_of_wrapping_paper/1" do
    test "UNIT - processes one line of wrapping paper dimensions" do
      assert Day02.total_square_feet_of_wrapping_paper(["2x3x4"]) == 58 
      assert Day02.total_square_feet_of_wrapping_paper(["1x1x10"]) == 43 
    end

    test "should return an integer representing the total square feet of wrapping paper needed from a list of present dimensions" do
      # 1456998 - too low
      assert Day02.total_square_feet_of_wrapping_paper(test_data()) == 1586300
    end

  end

  describe "total_feet_of_ribbon_needed/1" do
    test "UNIT - processes one line of ribbon" do
      assert Day02.total_feet_of_ribbon_needed(["2x3x4"]) == 34
      assert Day02.total_feet_of_ribbon_needed(["1x1x10"]) == 14
    end
    
    test "should return an integer indicating the total feet of ribbon needed" do
      # 3981220 - too high
      assert Day02.total_feet_of_ribbon_needed(test_data()) == 3737498
    end
  end
end
