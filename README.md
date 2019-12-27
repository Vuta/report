# EaModel

# Installation

- This app uses
    + [Benchee](https://github.com/bencheeorg/benchee) to benchmark
    + [Flow](https://github.com/plataformatec/flow) to parallel computation
    + [Excal](https://github.com/peek-travel/excal) to generate recurrence events

- `brew install libical` to install [libical](https://libical.github.io/libical/)
- `mix deps.get` to install dependencies

# Example dataset

``` elixir
[
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=0,10", value: 100}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=1,11", value: 90}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=2,12", value: 80}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=3,13", value: 70}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=4,14", value: 60}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=5,15", value: 50}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=6,16", value: 40}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=7,17", value: 30}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=8,18", value: 20}
  },
  %{
    id: 10,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=9,19,20,21,22,23", value: 10}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=0,10", value: 100}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=1,11", value: 90}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=2,12", value: 80}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=3,13", value: 70}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=4,14", value: 60}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=5,15", value: 50}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=6,16", value: 40}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=7,17", value: 30}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=8,18", value: 20}
  },
  %{
    id: 9,
    measured_rating: 1,
    profile: %{rrule: "FREQ=DAILY;BYHOUR=9,19,20,21,22,23", value: 10}
  }
]
```

# Benchmark

``` elixir
iex(1)> Benchee.run(%{
...(1)> "1000 items" => fn -> EaModel.Calculator.do_calculate(1..1000) end,
...(1)> "10_000 items" => fn -> EaModel.Calculator.do_calculate(1..10_000) end,
...(1)> "100_000 items" => fn -> EaModel.Calculator.do_calculate(1..100_000) end
...(1)> })
Operating System: macOS
CPU Information: Intel(R) Core(TM) i5-7360U CPU @ 2.30GHz
Number of Available Cores: 4
Available memory: 8 GB
Elixir 1.9.1
Erlang 22.1.8

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 21 s

Benchmarking 1000 items...
Benchmarking 100_000 items...
Benchmarking 10_000 items...

Name                    ips        average  deviation         median         99th %
1000 items            19.90       50.26 ms     ±5.46%       49.68 ms       61.82 ms
10_000 items           1.77      565.55 ms     ±2.02%      568.61 ms      578.53 ms
100_000 items         0.138     7242.55 ms     ±0.00%     7242.55 ms     7242.55 ms

Comparison:
1000 items            19.90
10_000 items           1.77 - 11.25x slower +515.29 ms
100_000 items         0.138 - 144.11x slower +7192.30 ms
```
