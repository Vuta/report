defmodule EaModel.MixProject do
  use Mix.Project

  def project do
    [
      app: :ea_model,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EaModel.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev},
      {:flow, "~> 0.14"},
      {:excal, "~> 0.3.2"}
    ]
  end
end
