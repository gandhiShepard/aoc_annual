defmodule Aoc2023.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day01

  describe "sum_calibration_numbers/1" do
    test "should return integer indication the sum of all calibration numbers" do
      data = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """

      test_data = "./test/aoc_2023/ben/data/day_01" |> File.read!()

      assert Day01.sum_calibration_numbers(data) == 142
      assert Day01.sum_calibration_numbers(test_data) == 53651
    end 
  end

  describe "sum_calibration_numbers_and_words/1" do
    test "should return integer indication the sum of all calibration numbers" do
      data = """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """

      test_data = "./test/aoc_2023/ben/data/day_01" |> File.read!()

      assert Day01.sum_calibration_numbers_and_words(data) == 281
      assert Day01.sum_calibration_numbers_and_words(test_data) == 53894
    end 

    test "error hunting" do
      # AHHHH! Its fucking mashup like:
      # oneight twone threeight fiveight sevenine eightwo eighthree nineight
      # soooo sneaky!!!

      data = """
      fourfour
      """      

      assert Day01.sum_calibration_numbers_and_words(data) == 44
    end
  end
end
