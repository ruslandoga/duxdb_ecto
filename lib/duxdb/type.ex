defmodule DuxDB.Type do
  @moduledoc """
  Special DuckDB types for Ecto.Schema

      schema "events" do
        # field <DuckDB name>, <Ecto.Schema or DuxDB.Type name)>
        field :BOOLEAN, :boolean
        field :TINYINT, :integer
        field :SMALLINT, :integer
        field :INTEGER, :integer
        field :BIGINT, :integer
        field :UTINYINT, :integer
        field :USMALLINT, :integer
        field :UINTEGER, :integer
        field :UBIGINT, :integer
        field :FLOAT, :float
        field :DOUBLE, :float
        field :TIMESTAMP, :naive_datetime
        field :DATE, :date
        field :TIME, :time
        field :INTERVAL, DuxDB.Type, duck: :interval
        field :HUGEINT, DuxDB.Type, duck: :hugeint
        field :UHUGEINT, DuxDB.Type, duck: :uhugeint
        field :VARCHAR, :string
        field :BLOB, :blob
        field :TIMESTAMP_S, :naive_datetime
        field :TIMESTAMP_MS, :naive_datetime_usec # truncated
        field :TIMESTAMP_NS, :naive_datetime_usec
        field :UUID, :uuid
        field :TIME_TZ, DuxDB.Type, duck: :time_tz
        field :TIMESTAMP_TZ, :utc_datetime
        # etc.
      end

  For details on DuckDB types see:
    - https://duckdb.org/docs/api/c/types.html -- list of all types
    - https://duckdb.org/docs/api/c/vector#primitive-types -- how they map to C types
    - https://duckdb.org/docs/sql/data_types/overview.html -- their SQL names

  """
  @behaviour Ecto.ParameterizedType

  @impl true
  def type(param) do
    {:parameterized, {__MODULE__, param}}
  end

  @impl true
  def init(opts) do
    Keyword.fetch!(opts, :duck)
  end
end
