defmodule DuxDB.Pool do
  @moduledoc "DBConnection on DuxDB"
  @behaviour DBConnection

  @type start_option ::
          {:database, Path.t()}
          | {:config, Enumerable.t()}
          | DBConnection.start_option()

  @spec start_link([start_option]) :: GenServer.on_start()
  def start_link(opts \\ []) do
    DBConnection.start_link(__MODULE__, opts)
  end

  @spec child_spec([start_option]) :: :supervisor.child_spec()
  def child_spec(opts) do
    DBConnection.child_spec(Connection, opts)
  end

  def query(pool, stmt, params \\ [], opts \\ []) do
    query = DuxDB.Pool.Query.build(stmt)

    with {:ok, _query, result} <- DBConnection.execute(pool, query, params, opts) do
      {:ok, result}
    end
  end

  def query!(pool, stmt, params \\ [], opts \\ []) do
    query = DuxDB.Pool.Query.build(stmt, opts)
    DBConnection.execute!(pool, query, params, opts)
  end
end
