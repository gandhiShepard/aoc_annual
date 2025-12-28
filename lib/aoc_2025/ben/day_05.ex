defmodule Ben.Day05 do
  @moduledoc ~S"""
  # Cafeteria
  """

  def total_fresh_ingredients_available(input = %Stream{}),
    do:
      with(
        {fresh_ingredient_id_ranges, available_ingredient_ids} =
          available_ingredient_ids_to_map(input),
        do:
          Enum.reduce(available_ingredient_ids, 0, fn
            id, acc ->
              acc +
                Enum.reduce_while(fresh_ingredient_id_ranges, 0, fn
                  {low, high}, acc ->
                    if id >= low and id <= high do
                      {:halt, 1}
                    else
                      {:cont, acc}
                    end
                end)
          end)
      )

  def total_ingredient_ids_considered_fresh(input = %Stream{}) do
    with(
      {fresh_ingredient_id_ranges, _available_ingredient_ids} =
        available_ingredient_ids_to_map(input),
      do:
        fresh_ingredient_id_ranges
        |> Enum.reduce([], fn range, acc ->
          Rangex.RangeList.add_range(acc, range)
        end)
        |> Enum.reduce(0, fn {l, h}, acc -> h - l + 1 + acc end)
        # both work
        # |> Enum.reduce(0, fn {l, h}, acc -> Enum.count(l..h) + acc end)
    )
  end

  def available_ingredient_ids_to_map(input = %Stream{}),
    do:
      input
      |> Stream.map(&String.split(&1, "-"))
      |> Enum.reduce({[], []}, fn
        [""], acc ->
          acc

        [low_id, high_id], {fresh_ingredient_id_ranges, available_ingredient_ids} ->
          {[{String.to_integer(low_id), String.to_integer(high_id)} | fresh_ingredient_id_ranges],
           available_ingredient_ids}

        [id], {fresh_ingredient_id_ranges, available_ingredient_ids} ->
          {fresh_ingredient_id_ranges, [String.to_integer(id) | available_ingredient_ids]}
      end)
end
