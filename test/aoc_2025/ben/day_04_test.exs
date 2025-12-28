defmodule Ben.Day04Test do
  use ExUnit.Case, async: true

  alias Ben.Day04
  doctest Day04, import: true


  # @test_data "priv/data/ben/day_04_data.txt"

  defp testdata, do: Path.join(:code.priv_dir(:aoc_2025), "data/ben/day_04_data.txt") |> File.stream!() |> Stream.map(&String.trim/1)
  defp testsample, do: Path.join(:code.priv_dir(:aoc_2025), "data/ben/day_04_example_data.txt") |> File.stream!() |> Stream.map(&String.trim/1)


  describe "Day 04 - Printing Department - part_one/1" do
    test "SAMPLE DATA should return an integer indicating the amount of rolls that have less than 4 adjacent rolls" do
      assert Day04.part_one(testsample()) == 13
    end

    test "CORE DATA should return an integer indicating the amount of rolls that have less than 4 adjacent rolls" do
      assert Day04.part_one(testdata()) == 1409
    end
  end

  describe "Day 04 - Printing Department - part_two/1" do
    test "SAMPLE DATA should return an integer indicating the amount of rolls that have been removed" do
      assert Day04.part_two(testsample()) == 43
    end

    test "CORE DATA should return an integer indicating the amount of rolls that have been removed" do
      assert Day04.part_two(testdata()) == 8366
    end
  end
  # defp stream_input(input) do
  #   input
  #   |> File.stream!()
  #   |> Stream.map(&String.trim/1)
  # end
end
