defmodule Pul.Day01Test do
  use ExUnit.Case, async: true
  alias Pul.Day01
  doctest Day01, import: true

  defp testsample, do: File.stream!("./test/pul/data/01_01_unit") |> Stream.map(&String.trim/1)
  defp testdata, do: File.stream!("./test/pul/data/01_01") |> Stream.map(&String.trim/1)

  describe "Day 01, part 01" do
    test "works with example" do
      assert Day01.dialed_zeroes(testsample()) == 3
    end
    test "works with test data" do
      assert Day01.dialed_zeroes(testdata()) == 995
    end
  end
  describe "Day 01, part 02" do
    test "works with example" do
      assert Day01.passed_zeroes(testsample()) == 6
    end
    test "works with test data" do
      assert Day01.passed_zeroes(testdata()) == 5847
    end
  end
end
