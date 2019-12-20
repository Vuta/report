defmodule EaModel do
  def energy_cost(measure_rating, profile_rrules, tariff_rrules, start_time, end_time) do
    on_off_profile = Profile.generate(profile_rrules)
  end
end
