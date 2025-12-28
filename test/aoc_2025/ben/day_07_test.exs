defmodule Ben.Day07Test do
  use ExUnit.Case, async: true

  alias Ben.Day07

  # defp test_example, do: "./test/ben/data/day_07_example.txt" |> File.read!()
  # defp test_data, do: "./test/ben/data/day_07_data.txt" |> File.read!()

  defp test_example, do: "./test/ben/data/day_07_example.txt" |> File.stream!() |> Stream.map(&String.trim/1)
  defp test_data, do: "./test/ben/data/day_07_data.txt" |> File.stream!() |> Stream.map(&String.trim/1)

  describe "Day 07 - Trash Compactor - part_one - total_beam_splits/1" do
    test "EXMAPLE DATA should return integer indicating the amount of times a tachyon beam is split" do
      assert Day07.total_beam_splits(test_example()) == 21
    end

    test "TEST DATA should return integer indicating the amount of times a tachyon beam is split" do
      assert Day07.total_beam_splits(test_data()) == 1690
    end
  end

  describe "Day 07 - Trash Compactor - part_one - total_timelines/1" do
    test "EXMAPLE DATA should return integer indicating the amount of timelines a single tachyon could end up on" do
      assert Day07.total_timelines(test_example()) == 40
    end

    test "TEST DATA should return integer indicating the amount of timelines a single tachyon could end up on" do
      assert Day07.total_timelines(test_data()) == 221371496188107
    end
  end
end
