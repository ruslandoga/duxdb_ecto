defmodule DuxDB.Ecto.Connection do
  @moduledoc false
  @behaviour Ecto.Adapters.SQL.Connection

  @impl true
  def child_spec(opts) do
    DBConnection.child_spec(DuxDB.Pool, opts)
  end

  @impl true
  def prepare_execute(conn, _name, statement, params, opts) do
    DBConnection.prepare_execute(conn, statement, params, opts)
  end

  @impl true
  def execute(conn, query, params, opts) do
    DBConnection.execute(conn, query, params, opts)
  end

  @impl true
  def query(conn, statement, params, opts) do
    DBConnection.query(conn, statement, params, opts)
  end

  @impl true
  def all(query, as_prefix \\ []) do
    []
  end
end
