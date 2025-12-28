defmodule Pul.Day06Test do
  use ExUnit.Case, async: true
  alias Pul.Day06
  doctest Day06, import: true

  defp testsample, do: File.stream!("./test/pul/data/06_01_unit") |> Stream.map(& &1) # don't trim!
  defp testdata, do: File.stream!("./test/pul/data/06_01") |> Stream.map(& &1)

  describe "Day 06, part 01" do
    test "works with example" do
      assert Day06.grand_total_of_solved_tasks(testsample()) == 4277556
    end
    test "works with test data" do
      assert Day06.grand_total_of_solved_tasks(testdata()) == 5171061464548
    end
  end
  describe "Day 06, part 02" do
    test "works with example" do
      assert Day06.grand_total_of_solved_tasks(testsample(), :right_to_left) == 3263827
    end
    test "works with test data" do
      assert Day06.grand_total_of_solved_tasks(testdata(), :right_to_left) == 10189959087258
    end
  end
end
