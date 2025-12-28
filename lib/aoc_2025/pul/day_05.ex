defmodule Pul.Day05 do

  def count_of_available_fresh_ingredients(inventory_list = %Stream{}),
    do:
      with(
        {ranges_of_fresh_ids, available_ids} = ranges_of_fresh_ids_and_available_ids(inventory_list),
        do: Enum.count(available_ids, &fresh_ingredient?(&1, ranges_of_fresh_ids)))

  defp ranges_of_fresh_ids_and_available_ids(inventory_list = %Stream{}),
    do: Enum.reduce(inventory_list, {:ranges_of_fresh_ids, [], []}, fn
            "", {:ranges_of_fresh_ids, ranges_of_fresh_ids, available_ids} ->
              {:available_ids, ranges_of_fresh_ids, available_ids}

            range_line, {:ranges_of_fresh_ids, ranges_of_fresh_ids, available_ids} ->
              [s, e] = String.split(range_line, "-") |> Enum.map(&String.to_integer/1)
              {:ranges_of_fresh_ids, [s..e | ranges_of_fresh_ids], available_ids}

            id_line, {:available_ids, ranges_of_fresh_ids, available_ids} ->
              id = String.to_integer(id_line)
              {:available_ids, ranges_of_fresh_ids, [id | available_ids]}

          end)
        |> then(fn {:available_ids, ranges_of_fresh_ids, available_ids} ->
            # reversing is not strictly necessary, since the order plays no role for the logic
            # it's just done for sake of consistency with the input data
            {Enum.reverse(ranges_of_fresh_ids), Enum.reverse(available_ids)} end)

  defp fresh_ingredient?(id, ranges_of_fresh_ids), do: Enum.any?(ranges_of_fresh_ids, & id in &1)

  def count_of_fresh_ingredients(inventory_list = %Stream{}),
    do:
      with(
        {ranges_of_fresh_ids, _available_ids} = ranges_of_fresh_ids_and_available_ids(inventory_list),
        merged_ranges = merge_ranges(ranges_of_fresh_ids),
        do: (for r <- merged_ranges, reduce: 0
          do
            c -> c + Enum.count(r)
          end))

  def merge_ranges([_.._| _] = ranges),
    do:
      ranges
      |> Enum.sort()
      |> Enum.reduce([], fn
          _.._ = first, [] -> [first]
          c_s..c_e = current, [l_s..l_e = last | previous] when c_s >= l_s ->
            if(c_s <= l_e + 1, do: [l_s..max(l_e, c_e) | previous], else: [current, last | previous])
        end)
      |> Enum.reverse()

end
