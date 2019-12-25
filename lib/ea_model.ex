defmodule EaModel do
  alias EaModel.Profile

  def aa(records) do
    %{area_id: 1, resource_use: 8760, resource_cost: 8760, resource_type: "electricity"}
  end

  def energy_cost(measure_rating, profile_rrules, tariff_rrules, start_time, end_time) do
    on_off_profile = Profile.generate(:on_off, profile_rrules)
    load_profile = Profile.generate(:load, profile_rrules)
    # tariff = Profile.generate(:tariff, tariff_rrules)

    {:ok, begin_of_year, _} = DateTime.from_iso8601("2019-01-01T00:00:00.00Z")

    Enum.reduce(start_time..end_time, %{use: 0}, fn i, acc ->
      time = DateTime.add(begin_of_year, 3600 * i, :second) |> DateTime.to_string()

      use = on_off_profile[time] * load_profile[time] * measure_rating

      Map.put(acc, :use, acc.use + use)
    end)
  end
end
