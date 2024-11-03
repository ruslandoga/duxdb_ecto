defmodule DuxDB.Pool.Query do
  @moduledoc false

  defstruct [:sql, :ref]

  defimpl DBConnection.Query do
  end
end
