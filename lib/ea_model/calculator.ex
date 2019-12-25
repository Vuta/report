defmodule EaModel.Calculator do
  alias EaModel.Profile

  def items do
    Enum.map(1..200, fn _x -> record() end)
  end

  def profiles do
    [
      %{rrule: "RRULE:FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
      %{rrule: "RRULE:FREQ=DAILY;BYHOUR=13,14,15,16,17,18,19,20,21,22,23", value: 0}
    ]
  end

  def record do
    %{
      load_profile: [
        %{rrule: "RRULE:FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 100},
        %{
          rrule: "RRULE:FREQ=DAILY;BYHOUR=13,14,15,16,17,18,19,20,21,22,23",
          value: 50
        }
      ],
      measured_rating: 1,
      on_off_profile: [
        %{rrule: "RRULE:FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12", value: 1},
        %{
          rrule: "RRULE:FREQ=DAILY;BYHOUR=13,14,15,16,17,18,19,20,21,22,23",
          value: 0
        }
      ]
    }
  end

  def do_calculate(record) do
    start_time = "2019-01-01T00:00:00"
    end_time = "2019-12-31T23:59:59.00Z"

    timeseries = Profile.generate(profiles(), start_time, end_time)

    use = 1
    %{area_id: 1, resource_use: use * record[:measured_rating], resource_cost: 1, resource_type: "electricity"}
  end

  def a do
    items()
    |> Task.async_stream(fn item ->
      begin = NaiveDateTime.utc_now()
      do_calculate(item)
      NaiveDateTime.diff(NaiveDateTime.utc_now(), begin, :millisecond) |> IO.inspect()
    end)
    |> Enum.to_list()
  end
end
