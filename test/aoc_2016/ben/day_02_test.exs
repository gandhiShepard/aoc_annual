defmodule Aoc2016.Ben.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2016.Ben.Day02

  describe "bathroom_decoder/1" do
    test "should return an integer that indicated the bathroom code" do

      _pad = """
      1 2 3
      4 5 6
      7 8 9
      """

      data = """
      ULL
      RRDDD
      LURDL
      UUUUD
      """

      test_data = "./test/aoc_2016/ben/data/day_02" |> File.read!()
      
      assert Day02.bathroom_decoder(data) == 1985
      assert Day02.bathroom_decoder(test_data) == 69642
    end
  end

  describe "real_bathroom_decoder/1" do
    test "should return an integer that indicated the bathroom code" do

      _pad = """
          1
        2 3 4
      5 6 7 8 9
        A B C
          D
      """

      data = """
      ULL
      RRDDD
      LURDL
      UUUUD
      """

      test_data = "./test/aoc_2016/ben/data/day_02" |> File.read!()
      
      assert Day02.real_bathroom_decoder(data) == "5DB3"
      assert Day02.real_bathroom_decoder(test_data) == "8CB23"
    end
  end
end
