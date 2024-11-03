defmodule DuxDB.Ecto do
  @moduledoc "Ecto on DuxDB"
  use Ecto.Adapters.SQL, driver: :duxdb
end
