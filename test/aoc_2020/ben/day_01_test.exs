defmodule Aoc2020.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2020.Ben.Day01

  defp test_data, do: "./test/aoc_2020/ben/data/day_01" |> File.read!()

  describe "expense_report_processor/1" do
    test "shoud" do
      data = """
      1721
      979
      366
      299
      675
      1456
      """

      assert Day01.expense_report_processor(data) == 514579
      assert Day01.expense_report_processor(test_data()) == 956091
    end
  end

  describe "expense_report_processor_next/1" do
    test "shoud" do
      data = """
      1721
      979
      366
      299
      675
      1456
      """

      assert Day01.expense_report_processor_next(data) == 241861950
      assert Day01.expense_report_processor_next(test_data()) == 79734368
    end
  end

end
