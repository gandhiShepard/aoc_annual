defmodule Ben.Day07 do
  @moduledoc ~S"""
  Laboratories
  """


  def total_beam_splits(tachyon_manifold_diagram = %Stream{}),
    do:
      with(
        diagram = Stream.map(tachyon_manifold_diagram, &String.split(&1, "", trim: true)),
        grid = make_grid(diagram),
        splitter_coords = find_splitters(grid),
        unique_beam_splits = Enum.map(splitter_coords, &beam_splits?(&1, grid)) |> List.flatten() |> MapSet.new(),
        starting_point = 1,
        do: 
          MapSet.size(unique_beam_splits) + starting_point)

  def total_timelines(tachyon_manifold_diagram = %Stream{}), 
    do:
      with(
        diagram = Stream.map(tachyon_manifold_diagram, &String.split(&1, "", trim: true)),
        last_level = Enum.count(diagram) - 1,
        grid = make_grid(diagram),
        start = find_start(grid),
        final_timeline_map = Enum.reduce(1..last_level, %{start => 1}, fn _, beams ->
        # IO.inspect(beams, label: ">>> beams")
          Enum.map(beams, fn {{row, col}, v} ->
              case grid[{row + 1, col}] do
                "." -> [{{row + 1, col}, v}]
                "^" -> [{{row + 1, col - 1}, v}, {{row + 1, col + 1}, v}]
              end
            end)
            |> List.flatten()
            |> Enum.reduce(%{}, fn 
                  {k, v}, acc -> Map.update(acc, k, v, &(&1 + v)) 
                end)
            end),

        do: 
          Enum.sum_by(final_timeline_map, fn {_k, v} -> v end))
          # count_timelines(start, grid))

  # defp count_timelines(coords, grid)

  # defp count_timelines({y, x}, grid) do
  #   case grid[{y + 1, x}] do
  #     "." -> count_timelines({y + 1, x}, grid)
  #     "^" -> count_timelines({y + 1, x - 1}, grid) + count_timelines({y + 1, x + 1}, grid)
  #     nil -> 1
  #   end
  # end

  defp find_start(grid), do: Enum.reduce_while(grid, nil, fn {{y, x}, _v}, acc -> if grid[{y, x}] == "S", do: {:halt, {y, x}}, else: {:cont, acc} end)

  defp find_splitters(map), do: Enum.filter(map, fn {_coords, symbol} -> symbol == "^" end) |> Enum.sort()

  defp beam_splits?({{y, x}, _symbol}, grid) do
    case {check_left(y , x, grid), check_right(y, x, grid)} do
      {{ly, lx, true}, {ry, rx, true}} -> [{{ly, lx}, "^"}, {{ry, rx}, "^"}]
      {{ly, lx, true}, {_ry, _rx, false}} -> [{{ly, lx}, "^"}]
      {{_ly, _lx, false}, {ry, rx, true}} -> [{{ry, rx}, "^"}]
      _ -> []
    end
  end

  defp check_left(y, x, grid) do
    case grid[{y + 1, x - 1}] do
      nil -> {y + 1, x - 1, false}
      "^" -> {y + 1, x - 1, true}
      "." -> 
        check_left(y + 1, x, grid)
    end
  end

  defp check_right(y, x, grid) do
    case grid[{y + 1, x + 1}] do
      nil -> {y + 1, x + 1, false}
      "^" -> {y + 1, x + 1, true}
      "." -> 
        check_right(y + 1, x, grid)
    end
  end

  defp make_grid(input) do
    for {row, i} <- Enum.with_index(input),
      {char, j} <- Enum.with_index(row),
      into: %{},
      do: {{i, j}, char}
  end
end
