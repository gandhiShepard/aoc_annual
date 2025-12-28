defmodule Ben.Day06 do
  @moduledoc ~S"""
  # Trash Compactor
  """

  def grand_total(input) do
    input
    |> Stream.map(&String.split(&1, " ", trim: true))
    |> Stream.zip_with(&Enum.reverse/1)
    |> Enum.reduce(0, fn
      ["*" | rest], acc ->
        rest
        |> Enum.map(fn num_str -> String.trim(num_str) |> String.to_integer() end)
        |> Enum.product()
        |> then(&Kernel.+(&1, acc))

      ["+" | rest], acc ->
        rest
        |> Enum.map(fn num_str -> String.trim(num_str) |> String.to_integer() end)
        |> Enum.sum()
        |> then(&Kernel.+(&1, acc))
    end)
    # |> dbg()
  end

  def cephalopod_grand_total(input) do
    input
    |> Stream.map(&String.split(&1, "\n", trim: true))
    |> Stream.flat_map(&List.flatten/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Stream.zip()
    |> Stream.map(&Tuple.to_list/1)
    |> Enum.to_list()
    |> format_rows()
    |> Enum.reduce(0, fn
      {"+", list}, acc -> Enum.sum(list) + acc
      {"*", list}, acc -> Enum.product(list) + acc
    end)
    # |> dbg()
  end

  defp format_rows(list)
  defp format_rows(list, temp \\ [], operator \\ nil, acc \\ [])
  defp format_rows([], temp, operator, acc), do: [{operator, temp} | acc]
  defp format_rows([row | rest], temp, operator, acc) do

      # Each row now has one of these signatures
      # ["1", " ", " ", "*"],
      # ["2", "4", " ", " "],
      # ["3", "5", "6", " "],
      # [" ", " ", " ", " "],

     cond do
       # is end of group
       Enum.all?(row, & &1 == " ") == true ->
         format_rows(rest, [], nil, [{operator, temp} | acc])

      # get operator and list of digits
       List.last(row) in  ["+", "*"] ->
         {operator, num} =
           row
           |> List.pop_at(-1)
           |> then(fn {operator, head_list} -> {operator, head_list |> Enum.join() |> String.trim() |> String.to_integer()} end)

           format_rows(rest, [num | temp], operator, acc)

       # just numbers to join
       true ->
         num = row |> Enum.join() |> String.trim() |> String.to_integer()
         format_rows(rest, [num | temp], operator, acc)
     end
  end

  # Rows will be formatted to look like this
  # {"+", [4, 431, 623]},
  # {"*", [175, 581, 32]},
  # {"+", [8, 248, 369]},
  # {"*", [356, 24, 1]}
end
