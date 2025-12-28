defmodule Pul.Day08 do

  def multiply_three_largest_circuits(junction_box_positions = %Stream{}, n_connections),
    do:
      with(
        {circuit_per_junction_box, closest_pairs} = circuits_and_closest_pairs(junction_box_positions),
        circuit_per_junction_box = Enum.reduce(Enum.take(closest_pairs, n_connections), circuit_per_junction_box, &connect/2),
        largest_three_circuits =
          (for c <- 1..Enum.max(Map.values(circuit_per_junction_box)),
             do: (for {j, ^c} <- circuit_per_junction_box, do: j))
          |> Enum.reject(&Enum.empty?/1)
          |> Enum.sort_by(&Enum.count/1, :desc)
          |> Enum.take(3),
        do: (for c <- largest_three_circuits, reduce: 1 do
                product -> product * Enum.count(c)
              end))

    defp circuits_and_closest_pairs(junction_box_positions = %Stream{}),
      do:
        with(
          circuits = Enum.reduce(junction_box_positions, %{}, fn line, boxes ->
            case String.split(line, ",") do
              [x, y, z] -> Map.put_new(boxes, {String.to_integer(x), String.to_integer(y), String.to_integer(z)}, 0)
            end
          end),
          junction_boxes = Map.keys(circuits),
          closest_pairs =
            for(j1 <- junction_boxes, j2 <- junction_boxes, j1 < j2, into: %{},
              do: {{j1, j2}, distance_square(j1, j2)})
            |> Enum.sort_by(fn {pair, distance} -> {distance, pair} end),
          do: {circuits, closest_pairs})


  defp distance_square({x1, y1, z1}, {x2, y2, z2}), do: (x2 - x1) ** 2 + (y2 - y1) ** 2 + (z2 - z1) ** 2

  defp connect({{j1, j2}, _distance}, circuit_per_junction_box) do
    case {Map.get(circuit_per_junction_box, j1), Map.get(circuit_per_junction_box, j2)} do
      {0, 0} ->
        new_circuit = Enum.max(Map.values(circuit_per_junction_box)) + 1
        circuit_per_junction_box
        |> Map.put(j1, new_circuit)
        |> Map.put(j2, new_circuit)

      {c1, c1} ->
        circuit_per_junction_box

      {c1, 0} ->
        circuit_per_junction_box
        |> Map.put(j2, c1)

      {0, c2} ->
        circuit_per_junction_box
        |> Map.put(j1, c2)

      {c1, c2} ->
        Map.new(circuit_per_junction_box, fn
          {j, ^c2} -> {j, c1}
          entry -> entry
        end)
    end
  end

  def distance_of_last_connection(junction_box_positions = %Stream{}),
    do:
      with(
        {circuit_per_junction_box, closest_pairs} = circuits_and_closest_pairs(junction_box_positions),
        {{{x1, _y1, _z1}, {x2, _y2, _z2}}, _distance} = last_connection(closest_pairs, circuit_per_junction_box, nil),
        do: x1 * x2)

  defp last_connection([closest_pair | closest_pairs], circuit_per_junction_box, last_pair) do
    case connect(closest_pair, circuit_per_junction_box) do
      ^circuit_per_junction_box -> last_connection(closest_pairs, circuit_per_junction_box, last_pair)
      circuit_per_junction_box -> last_connection(closest_pairs, circuit_per_junction_box, closest_pair)
    end
  end
  defp last_connection([], _circuit_per_junction_box, last_pair), do: last_pair

end
