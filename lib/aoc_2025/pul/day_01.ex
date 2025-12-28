defmodule Pul.Day01 do
  @initial_dial_position 50

  def dialed_zeroes(rotations),
    do: reduce_rotations(rotations, 0, &dialed_zeroes/2)

  defp dialed_zeroes(offset, {position, zeroes}) do
    case dial(position, offset) do
      0 -> {0, zeroes + 1}
      position when position in 1..99 -> {position, zeroes}
    end
  end

  defp dial(position, offset) when position + offset < 0, do: dial(position, offset + 100)
  defp dial(position, offset) when position + offset > 99, do: dial(position, offset - 100)
  defp dial(position, offset), do: position + offset

  def passed_zeroes(rotations),
    do: reduce_rotations(rotations, 0, &passed_zeroes/2)

  defp passed_zeroes(offset, {position, zeroes}) do
    zeroes = zeroes + zeroes_between(position, position + offset)
    case dial(position, offset) do
      0 -> {0, zeroes + 1}
      position when position in 1..99 -> {position, zeroes}
    end
  end

  defp zeroes_between(pos, o_pos) when pos in 0..99 and o_pos > 99 and rem(o_pos, 100) == 0, do: div(o_pos, 100) - 1
  defp zeroes_between(pos, o_pos) when pos in 0..99 and o_pos > 99, do: div(o_pos, 100)
  defp zeroes_between(pos, o_pos) when pos in 1..99 and o_pos < 0 and rem(o_pos, 100) == 0, do: -div(o_pos, 100) + 1 - 1
  defp zeroes_between(pos, o_pos) when pos in 1..99 and o_pos < 0, do: -div(o_pos, 100) + 1
  defp zeroes_between(0, o_pos) when o_pos < 0 and rem(o_pos, 100) == 0, do: -div(o_pos, 100) - 1
  defp zeroes_between(0, o_pos) when o_pos < 0, do: -div(o_pos, 100)
  defp zeroes_between(_, _), do: 0

  defp reduce_rotations(rotations, initial, reducer) when is_function(reducer, 2),
    do:
      rotations
      |> Stream.map(&offset/1)
      |> Stream.reject(&is_nil/1)
      |> Enum.reduce({@initial_dial_position, initial}, reducer)
      |> then(fn {_final_position, total} -> total end)

  defp offset("L" <> clicks), do: - String.to_integer(clicks)
  defp offset("R" <> clicks), do: String.to_integer(clicks)
  defp offset(_), do: nil

end
