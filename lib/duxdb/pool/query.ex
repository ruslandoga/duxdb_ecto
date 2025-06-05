defmodule DuxDB.Pool.Query do
  @moduledoc false

  defstruct [:sql, :ref]
  @type t :: %__MODULE__{sql: String.t(), ref: reference | nil}

  @doc false
  @spec new(iodata) :: t
  def new(sql) when is_binary(sql) do
    %__MODULE__{sql: sql}
  end

  def new(sql) when is_list(sql) do
    new(IO.iodata_to_binary(sql))
  end
end

defimpl DBConnection.Query, for: DuxDB.Pool.Query do
  alias DuxDB.Pool.Query

  # TODO
  @type opts :: Keyword.t()
  # TODO
  @type params :: [term] | Keyword.t() | map
  # TODO
  @type response :: map

  @spec parse(Query.t(), opts) :: Query.t()
  def parse(query, _opts), do: query

  @spec describe(Query.t(), opts) :: Query.t()
  def describe(query, _opts), do: query

  @spec encode(Query.t(), params, opts) :: Query.t()
  def encode(query, _params, _opts), do: query

  @spec decode(Query.t(), response, opts) :: map
  def decode(_query, response, _opts) do
    response
  end
end

defimpl String.Chars, for: DuxDB.Pool.Query do
  def to_string(%{sql: sql}), do: sql
end
