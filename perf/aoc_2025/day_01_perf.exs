alias Ben.Day01, as: Bens
alias Pul.Day01, as: Puls

# Run `mix run priv/perf/day_01_perf.exs`

test_data = %{
  "bens_data_stream" => "priv/data/ben/day_01_data.txt",
  # "puls_data_stream" => "priv/data/pul/day_01_data.txt",
}

Benchee.run(
  %{
    "BEN_PART_1" => &Bens.part1(&1),
    # "PUL_PART_1" => &Puls.part1(&1),
    #
    "BEN_PART_2" => &Bens.part2(&1),
    # "PUL_PART_2" => &Puls.part2(&1),
  },
  inputs: test_data
)

# ------------------------------------------------------------------------------

# First Solutions

##### With input bens_data_stream #####
# Name                 ips        average  deviation         median         99th %
# BEN_PART_1        1.05 K        0.95 ms     ±4.09%        0.94 ms        1.06 ms
# BEN_PART_2        0.97 K        1.03 ms     ±9.01%        1.04 ms        1.19 ms

# Refactored Solutions
##### With input bens_data_stream #####
# Name                 ips        average  deviation         median         99th %
# BEN_PART_1        1.17 K      855.57 μs     ±5.02%      850.96 μs      982.18 μs
# BEN_PART_2        1.13 K      887.28 μs    ±15.85%         883 μs     1011.86 μs

