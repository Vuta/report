defmodule EaModel.Profile do
  alias Cocktail.Schedule

  def do_generate(profile, start_time, end_time) do
    {:ok, schedule} = Schedule.from_i_calendar("DTSTART;TZID=Etc/UTC:#{start_time}\n#{profile.rrule}")

    schedule
    |> Schedule.occurrences()
    |> Stream.take_while(fn element -> DateTime.compare(element, end_time) == :lt end)
    |> Flow.from_enumerable()
    |> Flow.filter(fn element -> DateTime.compare(element, end_time) == :lt end)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn time, acc ->
      Map.put(acc, time, profile.value)
    end)
    |> Enum.to_list()
  end

  def generate(profile \\ nil, start_time \\ nil, end_time \\ nil) do
    start_time = "2019-01-01T00:00:00"
    end_time = "2019-12-31T23:59:59.00Z"
    start_time = String.replace(start_time, ~r/[-:]/, "")
    {:ok, end_time, _} = DateTime.from_iso8601(end_time)

    Enum.flat_map(profiles(), fn profile -> do_generate(profile, start_time, end_time) end)
  end

  def profiles do
    [
      %{rrule: "RRULE:FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "RRULE:FREQ=DAILY;BYHOUR=13,14,15,16,17,18,19,20,21,22,23", value: 0}
    ]
  end
end
