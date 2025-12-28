defmodule Pul.Day09Test do
  use ExUnit.Case, async: true
  alias Pul.Day09
  doctest Day09, import: true

  defp testsample, do: File.stream!("./test/pul/data/09_01_unit") |> Stream.map(&String.trim/1)
  defp testdata, do: File.stream!("./test/pul/data/09_01") |> Stream.map(&String.trim/1)

  describe "Day 09, part 01" do
    test "works with example" do
      assert Day09.largest_rectangle_between(testsample()) == 50
    end
    test "works with test data" do
      assert Day09.largest_rectangle_between(testdata()) == 4761736832
    end
  end
  # describe "Day 09, part 02" do
  #   test "works with example" do
  #     assert Day09.distance_of_last_connection(testsample()) == 25272
  #   end
  #   test "works with test data" do
  #     assert Day09.distance_of_last_connection(testdata()) == 27338688
  #   end
  # end
end
