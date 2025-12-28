defmodule Aoc2016.Ben.Day01 do
  @moduledoc """
  --- Day 1: No Time for a Taxicab ---
  """ 



  def walk_all_instructions(input) do
    input
    |> format_data()
    |> Enum.reduce({:north, {0, 0}}, &trace_walk/2)
    |> then(fn {_facing, {blocks_y, blocks_x}} -> abs(blocks_y) + abs(blocks_x) end)
  end

  defp trace_walk({:left, blocks}, {:north, {y, x}}), do: {:west, {y, x - blocks}}
  defp trace_walk({:left, blocks}, {:west, {y, x}}), do: {:south, {y + blocks, x}}
  defp trace_walk({:left, blocks}, {:south, {y, x}}), do: {:east, {y, x + blocks}}
  defp trace_walk({:left, blocks}, {:east, {y, x}}), do: {:north, {y - blocks, x}}

  defp trace_walk({:right, blocks}, {:north, {y, x}}), do: {:east, {y, x + blocks}}
  defp trace_walk({:right, blocks}, {:east, {y, x}}), do: {:south, {y + blocks, x}}
  defp trace_walk({:right, blocks}, {:south, {y, x}}), do: {:west, {y, x - blocks}}
  defp trace_walk({:right, blocks}, {:west, {y, x}}), do: {:north, {y - blocks, x}}

  def walk_until_position_repeated(input) do
    input
    |> format_data()
    |> Enum.reduce_while({:north, {0, 0}, MapSet.new([{0, 0}])}, &stop_at_repeated_position/2)
    |> MapSet.to_list()
    |> then(fn [{blocks_y, blocks_x}] -> abs(blocks_y) + abs(blocks_x) end)
  end

  defp stop_at_repeated_position({turn, blocks} = _instructions, {direction, _, _} = acc) do
    case {turn, direction} do
      {:left, :north} -> west(blocks, acc)
      {:left, :west} -> south(blocks, acc)
      {:left, :south} -> east(blocks, acc)
      {:left, :east} -> north(blocks, acc)

      {:right, :north} -> east(blocks, acc)
      {:right, :east} -> south(blocks, acc)
      {:right, :south} -> west(blocks, acc)
      {:right, :west} -> north(blocks, acc)
    end
  end

  defp north(blocks, {direction, {y, x}, seen}) do
    with(
      path = (for i <- blocks..1//-1, do: {y - i, x}),
      [new_position | _] = path,
      path_set = MapSet.new(path),
      result = seen?(:north, new_position, seen, path_set), 
      do: result
    )
  end

  defp south(blocks, {direction, {y, x}, seen}) do
    with(
      path = (for i <- blocks..1//-1, do: {y + i, x}),
      [new_position | _] = path,
      path_set = MapSet.new(path),
      result = seen?(:south, new_position, seen, path_set), 
      do: result
    )
  end

  defp east(blocks, {direction, {y, x}, seen}) do
    with(
      path = (for i <- blocks..1//-1, do: {y, x + i}),
      [new_position | _] = path,
      path_set = MapSet.new(path),
      result = seen?(:east, new_position, seen, path_set), 
      do: result
    )
  end

  defp west(blocks, {direction, {y, x}, seen}) do
    with(
      path = (for i <- blocks..1//-1, do: {y, x - i}),
      [new_position | _] = path,
      path_set = MapSet.new(path),
      result = seen?(:west, new_position, seen, path_set), 
      do: result
    )
  end

  defp seen?(direction, new_position, seen, path_set), 
    do:
      (if MapSet.disjoint?(seen, path_set), 
      do: {:cont, {direction, new_position, MapSet.union(seen, path_set)}}, 
      else: {:halt, MapSet.intersection(seen, path_set)})


  #
  # defp process_document_actual({:right, blocks} = _current_instructions, {:north, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:east, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:east, {y, x + blocks}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:right, blocks} = _current_instructions, {:west, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:north, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:north, {y - blocks, x}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:right, blocks} = _current_instructions, {:south, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:west, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:west, {y, x - blocks}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:right, blocks} = _current_instructions, {:east, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:south, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:south, {y + blocks, x}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  #
  #
  #
  # defp process_document_actual({:left, blocks} = _current_instructions, {:north, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:west, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:west, {y, x - blocks}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:left, blocks} = _current_instructions, {:west, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:south, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:south, {y + blocks, x}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:left, blocks} = _current_instructions, {:south, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:east, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:east, {y, x + blocks}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  # defp process_document_actual({:left, blocks} = _current_instructions, {:east, {y, x}, seen} = _acc) do
  #   set_to_be_traveled = trace_steps(:north, {y, x}, blocks) 
  #
  #   if MapSet.disjoint?(seen, set_to_be_traveled), 
  #     do: {:cont, {:north, {y - blocks, x}, MapSet.union(seen, set_to_be_traveled)}},
  #     else: {:halt, MapSet.intersection(seen, set_to_be_traveled)}
  # end
  #
  #
  #
  #
  #
  # defp trace_steps(:west, {y, x}, blocks),
  #   do: Stream.unfold(blocks, fn 0 -> nil; n -> {{y, x - n}, n - 1} end) |> MapSet.new()
  # 
  # defp trace_steps(:north, {y, x}, blocks), 
  #   do: Stream.unfold(blocks, fn 0 -> nil; n -> {{y - n, x}, n - 1} end) |> MapSet.new()
  # 
  # defp trace_steps(:east, {y, x}, blocks), 
  #   do: Stream.unfold(blocks, fn 0 -> nil; n -> {{y, x + n}, n - 1} end) |> MapSet.new()
  #
  # defp trace_steps(:south, {y, x}, blocks), 
  #   do: Stream.unfold(blocks, fn 0 -> nil; n -> {{y + n, x}, n - 1} end) |> MapSet.new()
  #
  
  defp format_data(input), 
    do: 
      input
      |> File.stream!()
      |> Stream.flat_map(&String.split(&1, ", "))
      # |> Enum.to_list()
      |> Stream.map(fn 
        "L" <> blocks -> {:left, String.to_integer(String.trim(blocks))}
        "R" <> blocks -> {:right, String.to_integer(String.trim(blocks))}
      end)
end
