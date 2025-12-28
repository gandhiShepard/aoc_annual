defmodule Ben.Day05Test do
  use ExUnit.Case, async: true

  alias Ben.Day05
  doctest Day05, import: true

  defp test_data, do: "./test/ben/data/day_05_data.txt" |> File.stream!() |> Stream.map(&String.trim/1)
  defp test_example, do: "./test/ben/data/day_05_example.txt" |> File.stream!() |> Stream.map(&String.trim/1)

  describe "Day 05 - Cafeteria - part_one - total_fresh_ingredients_available/1" do
    test "EXMAPLE DATA should return integer indicating amount of IDs that represent FRESH food" do
      assert Day05.total_fresh_ingredients_available(test_example()) == 3
    end

    test "TEST DATA should return integer indicating amount of IDs that represent FRESH food" do
      assert Day05.total_fresh_ingredients_available(test_data()) == 770
    end
  end

  describe "Day 05 - Cafeteria - part_two - total_ingredient_ids_considered_fresh/1 " do
    test "EXMAPLE DATA should return integer indicating amount of IDs that represent FRESH food" do
      assert Day05.total_ingredient_ids_considered_fresh(test_example()) == 14
    end

    test "TEST DATA should return integer indicating amount of IDs that represent FRESH food" do
      assert Day05.total_ingredient_ids_considered_fresh(test_data()) == 357674099117260
    end
  end

end
