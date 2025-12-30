defmodule Aoc2018.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2018.Ben.Day01

  defp test_data, do: "./test/aoc_2018/ben/data/day_01" |> File.read!()

  describe "frequencify/1" do
    test "should process frequency" do
      data1 = """
        +1
        +1
        +1
        """
      data2 = """
        +1
        +1
        -2
        """
      data3 = """
        -1
        -2
        -3
        """
      
        assert Day01.frequencify(data1) == 3
        assert Day01.frequencify(data2) == 0
        assert Day01.frequencify(data3) == -6

        assert Day01.frequencify(test_data()) == 437
    end
  end

  describe "first_repeated_frequency/1" do
    test "should return frist repeated frequency" do
      data1 = """
      +1
      -1
      """
      data2 = """
      +3
      +3
      +4
      -2
      -4
      """

      data3 = """
      -6
      +3
      +8
      +5
      -6
      """

      data4 = """
      +7
      +7
      -2
      -7
      -4
      """

      assert Day01.first_repeated_frequency(data1) == 0
      assert Day01.first_repeated_frequency(data2) == 10
      assert Day01.first_repeated_frequency(data3) == 5
      assert Day01.first_repeated_frequency(data4) == 14
      
      assert Day01.first_repeated_frequency(test_data()) == 655
    end
  end
end
