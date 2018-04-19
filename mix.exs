defmodule SslChecker.MixProject do
  use Mix.Project

  def project do
    [
      app: :ssl_checker,
      version: "0.1.0",
	  description: "Check host's SSL validity",
	  source_url: "https://github.com/awsmketchup/ssl-checker",
	  homepage_url: "https://github.com/awsmketchup/ssl-checker",
      elixir: "~> 1.6",
	  maintainers: ["Samuel Ralak"],
      start_permanent: Mix.env() == :prod,
	  package: [
		  maintainers: ["Samuel Ralak"],
		  licenses: ["GPL 3.0"],
		  links: %{github: "https://github.com/awsmketchup/ssl-checker"},
		  files: ~w(lib) ++ ~w(mix.exs README.md)
	  ],
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
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
