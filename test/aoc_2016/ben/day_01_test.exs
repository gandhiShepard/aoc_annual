defmodule Aoc2016.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2016.Ben.Day01

  defp test_data, do: "./test/aoc_2016/ben/data/day_01"

  setup do
    data1 = "R2, L3"
    data2 = "R2, R2, R2"
    data3 = "R5, L5, R5, R3"
    data4 = "R8, R4, R4, R8"

    file1 = "test_data_#{System.unique_integer([:positive])}.txt"
    file2 = "test_data_#{System.unique_integer([:positive])}.txt"
    file3 = "test_data_#{System.unique_integer([:positive])}.txt"
    file4 = "test_data_#{System.unique_integer([:positive])}.txt"

    temp_path1 = Path.join(System.tmp_dir(), file1)
    temp_path2 = Path.join(System.tmp_dir(), file2)
    temp_path3 = Path.join(System.tmp_dir(), file3)
    temp_path4 = Path.join(System.tmp_dir(), file4)

    File.write(temp_path1, data1)
    File.write(temp_path2, data2)
    File.write(temp_path3, data3)
    File.write(temp_path4, data4)


    on_exit(fn ->
      IO.puts("Cleaning up temporary files")
      File.rm(temp_path1)
      File.rm(temp_path2)
      File.rm(temp_path3)
      File.rm(temp_path4)
      # File.rm(temp_path4)
    end)

    # Return the temporary path so the test can access it in its context
    {:ok, 
      %{
        temp_path1: temp_path1, 
        temp_path2: temp_path2, 
        temp_path3: temp_path3,
        temp_path4: temp_path4
      }
    }
  end

  describe "blocks_aways_from_easter_bunny_hq/1" do
    test "UNIT - indicates blocks away", %{temp_path1: path1, temp_path2: path2, temp_path3: path3} do
      assert Day01.walk_all_instructions(path1) == 5   
      assert Day01.walk_all_instructions(path2) == 2
      assert Day01.walk_all_instructions(path3) == 12   
    end 

    test "indicates blocks away" do
      assert Day01.walk_all_instructions(test_data()) == 181
    end
  end

  describe "actual_blocks_away/1" do
    test "UNIT - indicates blocks away when block seen before", %{temp_path4: path4} do
      assert Day01.walk_until_position_repeated(path4) == 4 
    end

    test "actual blocks away" do
      assert Day01.walk_until_position_repeated(test_data()) == 140
    end
  end
end
