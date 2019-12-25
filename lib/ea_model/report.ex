defmodule EaModel.Report do
  use GenServer

  alias EaModel.Calculator

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def init(default) do
    {:ok, default}
  end

  def call({report_type, items}) do
    GenServer.call(__MODULE__, {report_type, items})
  end

  def handle_call({:summary_report, items}, from, state) do
    Task.Supervisor.start_child(Report.TaskSupervisor, fn ->
      result =
        items
        |> Enum.map(fn record ->
          Task.async(Calculator, :do_calculate, [record])
        end)
        |> Enum.reduce(%{resource_use: 0, resource_cost: 0, area_id: nil, resource_type: nil}, fn pid, acc ->
          pid
          |> Task.await()
          |> aggregate_result(acc)
        end)

      GenServer.reply(from, result)
    end)

    {:noreply, state}
  end

  def aggregate_result(row, result) do
    Map.merge(row, result, fn key, row_value, result_value ->
      case key do
        :area_id -> row_value
        :resource_type -> row_value
        _ -> row_value + result_value
      end
    end)
  end

  defp generate(records) do
    every_hour_a_year = "RRULE:FREQ=DAILY;BYHOUR=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"

    [
      %{item_id: 1, area_id: 1, profile_value: every_hour_a_year, measured_rating: 1, resource_type: "electricity"},
      %{item_id: 2, area_id: 1, profile_value: every_hour_a_year, measured_rating: 1, resource_type: "electricity"},
      %{item_id: 3, area_id: 1, profile_value: every_hour_a_year, measured_rating: 1, resource_type: "electricity"},
      %{item_id: 4, area_id: 1, profile_value: every_hour_a_year, measured_rating: 1, resource_type: "electricity"}
    ]
  end
end
