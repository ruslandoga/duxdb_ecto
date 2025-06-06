defmodule DuxDB.Ecto.MixProject do
  use Mix.Project

  def project do
    [
      app: :duxdb_ecto,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:duxdb, github: "ruslandoga/duxdb"},
      {:ecto_sql, "~> 3.12"},
      {:db_connection, "~> 2.0"}
    ]
  end
end
