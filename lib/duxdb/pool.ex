defmodule DuxDB.Pool do
  @moduledoc false
  use DBConnection

  @impl true
  @spec connect(database: DuxDB.db()) :: {:ok, DuxDB.conn()}
  def connect(opts) do
    db = Keyword.fetch!(opts, :database)
    {:ok, DuxDB.connect(db)}
  end

  @impl true
  def ping(conn), do: {:ok, conn}

  @impl true
  def checkout(conn), do: {:ok, conn}

  # TODO proper tx

  @impl true
  def handle_begin(_opts, conn), do: {:ok, %{}, conn}
  @impl true
  def handle_commit(_opts, conn), do: {:ok, %{}, conn}
  @impl true
  def handle_rollback(_opts, conn), do: {:ok, %{}, conn}
  @impl true
  def handle_status(_opts, conn), do: {:idle, conn}

  @impl true
  def handle_prepare(%DuxDB.Pool.Query{sql: sql} = query, _opts, conn) do
    # TODO ensure query.ref is nil?
    query = %DuxDB.Pool.Query{query | ref: DuxDB.prepare(conn, sql)}
    {:ok, query, conn}
  end

  @impl true
  def handle_close(%DuxDB.Pool.Query{ref: ref} = query, _opts, conn) do
    DuxDB.destroy_prepare(ref)
    query = %DuxDB.Pool.Query{query | ref: nil}
    {:ok, query, conn}
  end

  # TODO

  @impl true
  def handle_declare(query, _params, _opts, conn) do
    {:ok, query, _result = nil, conn}
  end

  @impl true
  def handle_fetch(_query, result, _opts, conn) do
    {:halt, result, conn}
  end

  def handle_deallocate(_query, result, _opts, conn) do
    {:ok, result, conn}
  end

  @impl true
  def handle_execute(query, _params, _opts, conn) do
    {:ok, query, %{}, conn}
  end

  @impl true
  def disconnect(_err, conn) do
    DuxDB.disconnect(conn)
  end
end
