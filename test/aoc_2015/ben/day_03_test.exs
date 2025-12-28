defmodule Aoc2015.Ben.Day03Test do
  use ExUnit.Case, async: true

  alias Aoc2015.Ben.Day03

  # defp test_data, do: File.stream!("./test/aoc_2015/ben/data/day_03", 1)
  defp test_data, do: "./test/aoc_2015/ben/data/day_03"

  setup do
    file1 = "test_data_#{System.unique_integer([:positive])}.txt"
    temp_path1 = Path.join(System.tmp_dir(), file1)
    data1 = ">"

    file2 = "test_data_#{System.unique_integer([:positive])}.txt"
    temp_path2 = Path.join(System.tmp_dir(), file2)
    data2 = "^>v<"

    file3 = "test_data_#{System.unique_integer([:positive])}.txt"
    temp_path3 = Path.join(System.tmp_dir(), file3)
    data3 = "^v^v^v^v^v"

    file4 = "test_data_#{System.unique_integer([:positive])}.txt"
    temp_path4 = Path.join(System.tmp_dir(), file4)
    data4 = "^v"

    File.write(temp_path1, data1)
    File.write(temp_path2, data2)
    File.write(temp_path3, data3)
    File.write(temp_path4, data4)

    on_exit(fn ->
      IO.puts("Cleaning up temporary files")
      # Use `File.rm!` for a synchronous, potentially crashing delete, or `File.rm`
      # and handle the result if you prefer graceful error handling.
      File.rm(temp_path1)
      File.rm(temp_path2)
      File.rm(temp_path3)
      File.rm(temp_path4)
    end)

    # Return the temporary path so the test can access it in its context
    {:ok, %{temp_path1: temp_path1, temp_path2: temp_path2, temp_path3: temp_path3, temp_path4: temp_path4}}
  end

  describe "homes_with_one_or_more_presents/1" do
    test "UNIT - processes short instructions", %{temp_path1: path1, temp_path2: path2, temp_path3: path3} do
      assert Day03.homes_with_one_or_more_presents(path1) == 2
      assert Day03.homes_with_one_or_more_presents(path2) == 4
      assert Day03.homes_with_one_or_more_presents(path3) == 2

    end

    test "should return integer indicating the amount of houses that get at least one present after following drop off instructions" do
      assert Day03.homes_with_one_or_more_presents(test_data()) == 2572
    end
  end

  describe "bobo_santa_homes_with_one_or_more_presents/1" do
    test "UNIT - processes short instructions", %{temp_path2: path2, temp_path3: path3, temp_path4: path4} do
      assert Day03.robo_santa_homes_with_one_or_more_presents(path4) == 3
      assert Day03.robo_santa_homes_with_one_or_more_presents(path2) == 3
      assert Day03.robo_santa_homes_with_one_or_more_presents(path3) == 11
    end

    test "should return integer indicating the amount of houses that get at least one present after following drop off instructions" do
      assert Day03.robo_santa_homes_with_one_or_more_presents(test_data()) == 2631
    end
  end

end
