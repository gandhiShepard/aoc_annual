defmodule Pul.Day07 do

  def count_of_splits(tachyon_manifold = %Stream{}),
    do:
      tachyon_manifold
      |> Enum.reduce(%{splits: 0}, &process/2)
      |> then(fn result -> result.splits end)

  def count_of_timelines(tachyon_manifold = %Stream{}),
    do:
      tachyon_manifold
      |> Enum.reduce(%{splits: 0}, &process/2)
      |> then(fn pathes ->
        for {col, pathes_ending_in_col} when is_integer(col) <- pathes, reduce: 0 do
          timelines -> timelines + pathes_ending_in_col
        end
      end)

  # given a row in the plan and the previous paths (counts of pathes leading through a column) calculates the new ones
  defp process(row, prev_pathes=%{splits: splits}) when is_binary(row),
    do:
      row
      |> to_char_list()
      |> Enum.with_index(0)
      |> Enum.reduce(%{splits: splits}, fn
          {?S, c}, pathes ->
            Map.put_new(pathes, c, 1)

          {?., c}, pathes ->
            pathes_leading_here = Map.get(prev_pathes, c, 0)
            pathes
            |> Map.update(c, pathes_leading_here, & &1 + pathes_leading_here)

          {?^, c}, pathes ->
            pathes_leading_to_this_splitter = Map.get(prev_pathes, c, 0)
            if(pathes_leading_to_this_splitter > 0) do
              pathes
              |> Map.update(c-1, pathes_leading_to_this_splitter, & &1 + pathes_leading_to_this_splitter)
              |> Map.update(c+1, pathes_leading_to_this_splitter, & &1 + pathes_leading_to_this_splitter)
              |> Map.update!(:splits, & &1 + 1)
            else
              pathes
            end
        end)

end
