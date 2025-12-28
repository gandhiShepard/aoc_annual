alias Ben.Day03, as: Bens
alias Pul.Day03, as: Puls

# Run `mix run priv/perf/day_03_perf.exs`

test_data = %{
  "bens_data_stream" => "priv/data/ben/day_03_data.txt",
}

Benchee.run(
  %{
    "BEN_PART_1" => &Bens.part_one(&1),
    "BEN_PART_2" => &Bens.part_two(&1),
  },
  inputs: test_data
)


##### With input bens_data_stream #####
# Name                 ips        average  deviation         median         99th %
# BEN_PART_1        921.81        1.08 ms     ±6.86%        1.08 ms        1.26 ms
# BEN_PART_2        427.73        2.34 ms     ±5.03%        2.33 ms        2.63 ms




# ------------------------------------------------------------------------------

# testdata = fn -> File.stream!("./test/pul/data/03_01") |> Stream.map(&String.trim/1) end
#
# test_data = %{
#   "puls_data_stream" => testdata.(),
# }
#
# Benchee.run(
#   %{
#     "PUL_PART_1" => &Puls.total_output_joltage(&1, 2),
#     "PUL_PART_2" => &Puls.total_output_joltage(&1, 12),
#   },
#   inputs: test_data
# )


##### With input puls_data_stream #####
# Name                 ips        average  deviation         median         99th %
# PUL_PART_1        2.30 K      434.01 μs     ±6.23%      430.08 μs      514.71 μs
# PUL_PART_2        1.66 K      602.96 μs     ±4.19%      598.92 μs      685.75 μs

