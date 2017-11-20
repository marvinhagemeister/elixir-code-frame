defmodule CodeFrame.MixProject do
  use Mix.Project

  def project do
    [
      app: :code_frame,
      version: "0.1.0",
      elixir: "~> 1.6-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "CodeFrame",
      source_url: "https://github.com/marvinhagemeister/elixir-code-frame",
      docs: [
        main: "CodeFrame", # The main page in the docs
        extras: ["README.md"]
      ]
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
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:exfmt, "~> 0.2", only: :dev}
    ]
  end
end