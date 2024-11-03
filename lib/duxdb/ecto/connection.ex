defmodule DuxDB.Ecto.Connection do
  @moduledoc false
  @behaviour Ecto.Adapters.SQL.Connection

  def all(_query) do
    []
  end
end
