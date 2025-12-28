defmodule Pul.Day07Test do
  use ExUnit.Case, async: true
  alias Pul.Day07
  doctest Day07, import: true

  defp testsample, do: File.stream!("./test/pul/data/07_01_unit") |> Stream.map(&String.trim/1)
  defp testdata, do: File.stream!("./test/pul/data/07_01") |> Stream.map(&String.trim/1)

  describe "Day 07, part 01" do
    test "works with example" do
      assert Day07.count_of_splits(testsample()) == 21
    end
    test "works with test data" do
      assert Day07.count_of_splits(testdata()) == 1543
    end
  end
  describe "Day 07, part 02" do
    test "works with example" do
      assert Day07.count_of_timelines(testsample()) == 40
    end
    test "works with test data" do
      assert Day07.count_of_timelines(testdata()) == 3223365367809
    end
  end
end
