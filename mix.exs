defmodule AocAnnual.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc_annual,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7.7", only: [:dev, :test], runtime: false},
      {:benchee, "~> 1.5", only: :dev},
      {:stream_data, "~> 1.2", only: [:test, :dev]},
      {:rangex, "~> 0.1.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
