alias Ben.Day02, as: Bens
alias Pul.Day02, as: Puls

# Run `mix run priv/perf/day_02_perf.exs`

test_data = %{
  "bens_data_stream" => "priv/data/ben/day_02_data.txt",
  # "puls_data_stream" => "priv/data/pul/day_02_data.txt",
}

Benchee.run(
  %{
    "BEN_PART_1" => &Bens.part_one(&1),
    # "PUL_PART_1" => &Puls.part1(&1),
    #
    "BEN_PART_2" => &Bens.part_two(&1),
    # "PUL_PART_2" => &Puls.part2(&1),
  },
  inputs: test_data
)

# ------------------------------------------------------------------------------

# First Solutions

# Name                 ips        average  deviation         median         99th %
# BEN_PART_1         12.57       0.0795 s     ±1.39%       0.0794 s       0.0825 s
# BEN_PART_2          0.50         2.02 s     ±0.25%         2.02 s         2.03 s

