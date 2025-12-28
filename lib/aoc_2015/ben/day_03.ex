defmodule Aoc2015.Ben.Day03 do
  def homes_with_one_or_more_presents(input) do
    input
    |> File.stream!(1)
    |> Enum.reduce({{0, 0}, %{{0, 0} => 0}}, &process_directions/2)
    |> elem(1)
    |> map_size()
  end

  defp process_directions("\n", acc), do: acc
  defp process_directions("^", {{y, x}, homes_visited}), do: {{y - 1, x}, Map.update(homes_visited, {y - 1, x}, 0, & &1 + 1)}
  defp process_directions(">", {{y, x}, homes_visited}), do: {{y, x + 1}, Map.update(homes_visited, {y, x + 1}, 0, & &1 + 1)}
  defp process_directions("<", {{y, x}, homes_visited}), do: {{y, x - 1}, Map.update(homes_visited, {y, x - 1}, 0, & &1 + 1)}
  defp process_directions("v", {{y, x}, homes_visited}), do: {{y + 1, x}, Map.update(homes_visited, {y + 1, x}, 0, & &1 + 1)}

  def robo_santa_homes_with_one_or_more_presents(input) do
    input
    |> File.stream!(2)
    |> Enum.reduce({{0, 0}, {0, 0}, %{{0, 0} => 0}}, &process_two_directions/2)
    |> elem(2)
    |> map_size()
  end

  defp process_two_directions("\n", acc), do: acc
  defp process_two_directions(both_directions, acc) do
    acc = update_santa_position(both_directions, acc)
    update_robo_position(both_directions, acc)
  end
  
  defp update_santa_position("^" <> _, {{y, x}, robo, homes_visited}), do: {{y - 1, x}, robo, Map.update(homes_visited, {y - 1, x}, 0, & &1 + 1)}
  defp update_santa_position(">" <> _, {{y, x}, robo, homes_visited}), do: {{y, x + 1}, robo, Map.update(homes_visited, {y, x + 1}, 0, & &1 + 1)}
  defp update_santa_position("<" <> _, {{y, x}, robo, homes_visited}), do: {{y, x - 1}, robo, Map.update(homes_visited, {y, x - 1}, 0, & &1 + 1)}
  defp update_santa_position("v" <> _, {{y, x}, robo, homes_visited}), do: {{y + 1, x}, robo, Map.update(homes_visited, {y + 1, x}, 0, & &1 + 1)}

  defp update_robo_position(<<_::binary-size(1), "^">>, {santa, {y, x}, homes_visited}), do: {santa, {y - 1, x}, Map.update(homes_visited, {y - 1, x}, 0, & &1 + 1)}
  defp update_robo_position(<<_::binary-size(1), ">">>, {santa, {y, x}, homes_visited}), do: {santa, {y, x + 1}, Map.update(homes_visited, {y, x + 1}, 0, & &1 + 1)}
  defp update_robo_position(<<_::binary-size(1), "<">>, {santa, {y, x}, homes_visited}), do: {santa, {y, x - 1}, Map.update(homes_visited, {y, x - 1}, 0, & &1 + 1)}
  defp update_robo_position(<<_::binary-size(1), "v">>, {santa, {y, x}, homes_visited}), do: {santa, {y + 1, x}, Map.update(homes_visited, {y + 1, x}, 0, & &1 + 1)}
end
