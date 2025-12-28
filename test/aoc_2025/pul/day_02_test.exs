defmodule Pul.Day02Test do
  use ExUnit.Case, async: true
  alias Pul.Day02
  doctest Day02, import: true

  defp testsample, do: File.read!("./test/pul/data/02_01_unit")
  defp testdata, do: File.read!("./test/pul/data/02_01")

  describe "Day 02, part 01" do
    test "invalid ids" do
      assert Day02.invalid?("4747", true)
      assert Day02.invalid?("51475147", true)
    end
    test "invalid ids, when odd reps invalid" do
      assert Day02.invalid?("111", false)
      assert Day02.invalid?("824824824", false)
    end
    test "valid ids with odd reps valid" do
      refute Day02.invalid?("111", true)
      refute Day02.invalid?("824824824", true)
      refute Day02.invalid?("4748", true)
      refute Day02.invalid?("474847481", true)
    end
    test "works with example" do
      assert Day02.sum_of_invalid_IDs(testsample(), true) == 1227775554
    end
    test "works with test data" do
      assert Day02.sum_of_invalid_IDs(testdata(), true) == 30599400849
    end
  end
  describe "Day 02, part 02" do
    test "works with example" do
      assert Day02.sum_of_invalid_IDs(testsample(), false) == 4174379265
    end
    test "works with test data" do
      assert Day02.sum_of_invalid_IDs(testdata(), false) == 46270373595
    end
  end
end
