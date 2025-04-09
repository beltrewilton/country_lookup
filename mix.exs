defmodule CountryLookup.MixProject do
  use Mix.Project

  @version "0.0.2"
  @repo_url "https://github.com/beltrewilton/country_lookup"

  def project do
    [
      app: :country_lookup,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description:
        "A lightweight Elixir library for identifying countries by their telephone dialing codes",
      package: package(),

      # Docs
      name: "country_lookup",
      docs: [
        name: "country_lookup",
        source_ref: "v#{@version}",
        source_url: @repo_url,
        homepage_url: @repo_url,
        main: "readme",
        extras: ["README.md"],
        links: %{
          "GitHub" => @repo_url,
          "Sponsor" => "https://github.com/beltrewilton/"
        }
      ]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => @repo_url
      },
      files: [
        "lib",
        ".formatter.exs",
        "mix.exs",
        "README*",
        "data",
        "python_skrap"
      ],
      exclude_patterns: ["python_skrap/flags"]
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
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.37.3", only: :dev, runtime: false}
    ]
  end
end
