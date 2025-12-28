defmodule Pul.Day02 do
  @max_len_rep_pattern 5
  @min_len_rep_pattern 1
  def sum_of_invalid_IDs(id_ranges, odd_repetions_valid? \\ true) do
    for id_range <- String.split(id_ranges, ","),
        [first, last] = Enum.map(String.split(id_range, "-"), &String.to_integer/1),
        id <- first..last,
        invalid?(to_string(id), odd_repetions_valid?),
        reduce: 0 do
      sum -> sum + id
    end
  end

  def invalid?(id_string, odd_repetions_valid?)
  for len <- @max_len_rep_pattern..@min_len_rep_pattern, size = 8 * len do
    # match strings with 8 - 2 repetitions of the given pattern length, odd counts are only match if they are not valid
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size)>>, _), do: true
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size)>>, false), do: true
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size)>>, _), do: true
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size)>>, false), do: true
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size), p::unquote(size)>>, _), do: true
    def invalid?(<<p::unquote(size), p::unquote(size), p::unquote(size)>>, false), do: true
    def invalid?(<<p::unquote(size), p::unquote(size)>>, _), do: true
  end
  def invalid?(_, _), do: false
end
