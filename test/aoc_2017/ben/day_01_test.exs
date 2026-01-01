defmodule Aoc2017.Ben.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2017.Ben.Day01

  # ok, this is getting a little bit crazy!

  setup do
    data1 = "1122"
    data2 = "1111"
    data3 = "1234"
    data4 = "91212129"

    data5 = "1212"
    data6 = "1221"
    data7 = "123425"
    data8 = "123123"
    data9 = "12131415"

    file1 = "test_data_#{System.unique_integer([:positive])}.txt"
    file2 = "test_data_#{System.unique_integer([:positive])}.txt"
    file3 = "test_data_#{System.unique_integer([:positive])}.txt"
    file4 = "test_data_#{System.unique_integer([:positive])}.txt"

    file5 = "test_data_#{System.unique_integer([:positive])}.txt"
    file6 = "test_data_#{System.unique_integer([:positive])}.txt"
    file7 = "test_data_#{System.unique_integer([:positive])}.txt"
    file8 = "test_data_#{System.unique_integer([:positive])}.txt"
    file9 = "test_data_#{System.unique_integer([:positive])}.txt"


    temp_path1 = Path.join(System.tmp_dir(), file1)
    temp_path2 = Path.join(System.tmp_dir(), file2)
    temp_path3 = Path.join(System.tmp_dir(), file3)
    temp_path4 = Path.join(System.tmp_dir(), file4)

    temp_path5 = Path.join(System.tmp_dir(), file5)
    temp_path6 = Path.join(System.tmp_dir(), file6)
    temp_path7 = Path.join(System.tmp_dir(), file7)
    temp_path8 = Path.join(System.tmp_dir(), file8)
    temp_path9 = Path.join(System.tmp_dir(), file9)


    File.write(temp_path1, data1)
    File.write(temp_path2, data2)
    File.write(temp_path3, data3)
    File.write(temp_path4, data4)

    File.write(temp_path5, data5)
    File.write(temp_path6, data6)
    File.write(temp_path7, data7)
    File.write(temp_path8, data8)
    File.write(temp_path9, data9)


    on_exit(fn ->
      IO.puts("Cleaning up temporary files")
      File.rm(temp_path1)
      File.rm(temp_path2)
      File.rm(temp_path3)
      File.rm(temp_path4)

      File.rm(temp_path5)
      File.rm(temp_path6)
      File.rm(temp_path7)
      File.rm(temp_path8)
      File.rm(temp_path9)
    end)

    # Return the temporary path so the test can access it in its context
    {:ok, 
      %{
        temp_path1: temp_path1, 
        temp_path2: temp_path2, 
        temp_path3: temp_path3,
        temp_path4: temp_path4,

        temp_path5: temp_path5, 
        temp_path6: temp_path6, 
        temp_path7: temp_path7,
        temp_path8: temp_path8,
        temp_path9: temp_path9
      }
    }
  end
  
  defp test_data, do: "./test/aoc_2017/ben/data/day_01" |> stream()


  describe "captcha_solver/1" do
    test "UNIT - should produce the correct sum", %{temp_path1: path1, temp_path2: path2, temp_path3: path3, temp_path4: path4} do
      assert Day01.captcha_solver(stream(path1)) == 3
      assert Day01.captcha_solver(stream(path2)) == 4
      assert Day01.captcha_solver(stream(path3)) == 0
      assert Day01.captcha_solver(stream(path4)) == 9
    end

    test "test data" do
      assert Day01.captcha_solver(test_data()) == 1119
    end
  end

  describe "captcha_solver_b/1" do
    test "UNIT - should produce the correct sum B", %{temp_path5: path5, temp_path6: path6, temp_path7: path7, temp_path8: path8, temp_path9: path9} do
      assert Day01.captcha_solver_b(stream(path5)) == 6
      assert Day01.captcha_solver_b(stream(path6)) == 0
      assert Day01.captcha_solver_b(stream(path7)) == 4
      assert Day01.captcha_solver_b(stream(path8)) == 12
      assert Day01.captcha_solver_b(stream(path9)) == 4
    end

    test "test data" do
      assert Day01.captcha_solver_b(test_data()) == 1420
    end
  end

  defp stream(input), 
    do:
      input
      |> File.stream!(1)
      |> Stream.reject(& &1 == "\n")
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()
end
