defmodule EaModel.Profile do
  alias Excal.Recurrence

  def generate(rrule, start_time, end_time) do
    {:ok, stream} = Recurrence.Stream.new(rrule, start_time)

    stream
    |> Stream.take_while(fn element -> NaiveDateTime.compare(element, end_time) == :lt end)
    |> Enum.to_list()
  end
end
