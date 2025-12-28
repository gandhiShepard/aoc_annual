defmodule Ben.Day08Test do
  use ExUnit.Case, async: true

  alias Ben.Day08

  defp test_example, do: "./test/ben/data/day_08_example.txt" |> File.read!()
  defp test_data, do: "./test/ben/data/day_08_data.txt" |> File.stream!() |> Stream.map(&String.trim/1)

  describe "Day 08 - Playground - part_one - total_beam_splits/1" do
    test "EXMAPLE DATA should return integer indicating the product of the three largest circuts" do
      assert Day08.solve(test_example()) == 40
      # assert Day08.product_of_thee_largest_circuts(test_example()) == 40
    end

    # test "TEST DATA should return integer indicating the product of the three largest circuts" do
    #   assert Day08.product_of_thee_largest_circuts(test_data()) == 1
    # end
  end

  # describe "Day 08 - Playground - part_one - total_timelines/1" do
  #   test "EXMAPLE DATA should return integer indicating the amount of timelines a single tachyon could end up on" do
  #     assert Day08.total_timelines(test_example()) == 40
  #   end
  #
  #   test "TEST DATA should return integer indicating the amount of timelines a single tachyon could end up on" do
  #     assert Day08.total_timelines(test_data()) == 221371496188107
  #   end
  # end

end
