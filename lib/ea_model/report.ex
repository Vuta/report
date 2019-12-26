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
    GenServer.call(__MODULE__, {report_type, items}, :infinity)
  end

  def handle_call({:summary_report, items}, from, state) do
    Task.Supervisor.start_child(Report.TaskSupervisor, fn ->
      result = Calculator.do_calculate(items)
      GenServer.reply(from, result)
    end)

    {:noreply, state}
  end
end
