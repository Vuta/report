defmodule EaModel.Profile do
  alias Cocktail.Schedule
  alias Excal.Recurrence

  def do_generate(profile, start_time, end_time) do
    {:ok, stream} = Recurrence.Stream.new(profile.rrule, start_time)

    stream
    |> Stream.take_while(fn element -> NaiveDateTime.compare(element, end_time) == :lt end)
    |> Flow.from_enumerable()
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn time, acc ->
      Map.put(acc, time, 1)
    end)
    |> Enum.into(%{})
  end

  def generate(profile \\ nil, start_time \\ nil, end_time \\ nil) do
    start_time = ~N[2019-01-01 00:00:00]
    end_time = ~N[2019-12-31 23:59:59]

    profiles
    |> Task.async_stream(fn profile ->
      EaModel.Profile.do_generate(profile, start_time, end_time)
    end)
    |> Enum.reduce(%{}, fn {:ok, map}, acc ->
      Map.merge(acc, map)
    end)
  end

  def profiles do
    [
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=13,14,15,16,17,18,19,20,21,22,23", value: 0},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100}
    ]
  end
end
