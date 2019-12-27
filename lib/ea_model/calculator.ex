defmodule EaModel.Calculator do
  alias EaModel.Profile

  def items(list) do
    Enum.reduce(list, [], fn i, acc -> records(i) ++ acc end)
  end

  def load_profiles do
    [
      %{rrule: "FREQ=DAILY;BYHOUR=0,10", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=1,11", value: 90},
      %{rrule: "FREQ=DAILY;BYHOUR=2,12", value: 80},
      %{rrule: "FREQ=DAILY;BYHOUR=3,13", value: 70},
      %{rrule: "FREQ=DAILY;BYHOUR=4,14", value: 60},
      %{rrule: "FREQ=DAILY;BYHOUR=5,15", value: 50},
      %{rrule: "FREQ=DAILY;BYHOUR=6,16", value: 40},
      %{rrule: "FREQ=DAILY;BYHOUR=7,17", value: 30},
      %{rrule: "FREQ=DAILY;BYHOUR=8,18", value: 20},
      %{rrule: "FREQ=DAILY;BYHOUR=9,19,20,21,22,23", value: 10}
    ]
  end

  def records(i) do
    Enum.map(load_profiles(), fn profile ->
      %{
        id: i,
        profile: profile,
        measured_rating: 1,
      }
    end)
  end

  def do_calculate(range) do
    start_time = ~N[2019-01-01 00:00:00]
    end_time = ~N[2019-12-31 23:59:59]

    rrules =
      Enum.map(items(range), fn item ->
        item[:profile][:rrule]
      end)
      |> Enum.uniq()
      |> Enum.reduce(%{}, fn rrule, acc ->
        timeseries = Profile.generate(rrule, start_time, end_time)
        Map.put(acc, rrule, timeseries)
      end)

    items(range)
    |> Flow.from_enumerable()
    |> Flow.map(fn item ->
      rule = item[:profile][:rrule]
      use = length(rrules[rule]) * item[:profile][:value] * item[:measured_rating] / 100
      Map.put(item, :use, use)
    end)
    |> Enum.reduce(0, fn item, acc ->
      acc + item[:use]
    end)
  end
end
