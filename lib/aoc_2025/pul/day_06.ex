defmodule Pul.Day06 do

  defguardp is_op(op) when op in [?+, ?*]

  def grand_total_of_solved_tasks(task_table = %Stream{}),
    do:
      with(
        tasks = tasks(task_table),
        do: (for task <- tasks, reduce: 0 do
          grand_total -> grand_total + solve(task)
        end))

  defp tasks(task_table = %Stream{}),
    do:
      task_table
      |> Stream.map(&String.split/1)
      |> Enum.zip()

  defp solve(task) when is_tuple(task),
    do:
      with(
        number_of_args = tuple_size(task) - 1,
        op = elem(task, number_of_args),
        reducer = reducer(op),
        do: Enum.reduce(1..number_of_args-1, String.to_integer(elem(task, 0)), fn arg_index, result ->
          reducer.(result, String.to_integer(elem(task, arg_index))) end))

  defp reducer("+"), do: &Kernel.+/2
  defp reducer("*"), do: &Kernel.*/2
  defp reducer(?+), do: &Kernel.+/2
  defp reducer(?*), do: &Kernel.*/2

  def grand_total_of_solved_tasks(task_table = %Stream{}, :right_to_left),
    do:
      with(
        [operator_line | reversed_parameter_lines] = Enum.reduce(task_table, [], &[&1 | &2]),
        do: total(operator_line, Enum.reverse(reversed_parameter_lines), 0))

  defp total(<<op::8, ?\s::8, ?\s::8, ?\s::8, ?\n::8>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 4, <<>>, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\s::8, ?\n::8>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 3, <<>>, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\n::8>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 2, <<>>, parameter_lines, total)
  defp total(<<op::8>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 1, <<>>, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\s::8, ?\s::8, ?\s::8, ?\s::8, operator_line::binary>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 5, operator_line, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\s::8, ?\s::8, ?\s::8, operator_line::binary>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 4, operator_line, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\s::8, ?\s::8, operator_line::binary>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 3, operator_line, parameter_lines, total)
  defp total(<<op::8, ?\s::8, ?\s::8, operator_line::binary>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 2, operator_line, parameter_lines, total)
  defp total(<<op::8, ?\s::8, operator_line::binary>>, parameter_lines, total)
    when is_op(op), do: evaluate(op, 1, operator_line, parameter_lines, total)
  defp total(<<>>, _, total), do: total

  defp evaluate(op, n_params, operator_line, parameter_lines, total) when is_op(op) and n_params in 1..4,
    do:
      with(
        [p1 | parameters] = for(p <- 1..n_params, do:
          for(l <- parameter_lines, digit = String.at(l, p - 1), digit != " ", do: digit)
          |> Enum.join("") |> String.to_integer()),
        total = total + Enum.reduce(parameters, p1, reducer(op)),
        parameter_lines = Enum.map(parameter_lines, &String.slice(&1, n_params + 1, 100_000)),
        do: total(operator_line, parameter_lines, total))

end
