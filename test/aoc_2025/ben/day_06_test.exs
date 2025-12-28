defmodule Ben.Day06Test do
  use ExUnit.Case, async: true

  alias Ben.Day06

  defp test_example, do: "./test/ben/data/day_06_example.txt" |> File.stream!()
  defp test_data, do: "./test/ben/data/day_06_data.txt" |> File.stream!()

  defp stream_file(file_path), do: file_path |> File.stream!() |> Stream.map(&String.trim/1)

  describe "Day 06 - Trash Compactor - part_one - grand_total/1" do
    test "EXMAPLE DATA should return integer indicating grand total of all the equations on the worksheet" do
      assert Day06.grand_total(test_example()) == 4_277_556
    end

    test "TEST DATA should return integer indicating grand total of all the equations on the worksheet" do
      assert Day06.grand_total(test_data()) == 5_346_286_649_122
    end
  end

  describe "Day 06 - Trash Compactor - part_two - cephalopod_grand_total/1 " do
    test "EXMAPLE DATA should return integer indicating grand total of all the cephalopod equations on the worksheet" do
      assert Day06.cephalopod_grand_total(test_example()) == 3_263_827
    end

    test "TEST DATA should return integer indicating grand total of all the cephalopod equations on the worksheet" do
      assert Day06.cephalopod_grand_total(test_data()) == 10_389_131_401_929
    end
  end

end
