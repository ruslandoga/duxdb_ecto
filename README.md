Basic Ecto adapter for DuckDB.

```sh
brew install duckdb llvm

duckdb --version
# v1.1.3 19864453f7

clang --version
# Homebrew clang version 19.1.6

export CC=$(which clang)
export DUXDB_LDFLAGS=-L/opt/homebrew/opt/duckdb/lib
```

```elixir
Mix.install([
  {:duxdb_ecto, [github: "ruslandoga/duxdb_ecto"]}
])

defmodule Repo do
  use Ecto.Repo, adapter: DuxDB.Ecto, otp_app: :demo
end

Application.put_env(:demo, Repo, database: ":memory:")
Repo.start_link()

Repo.query!("""
copy (
  select * from range(1, 10000000)
) to 'events.parquet.lz4' (
  format parquet, compression lz4_raw
)
""")

import Ecto.Query

file = "events.parquet.lz4"
events_q = from e in fragment("read_parquet(?)", ^file)

Repo.aggregate(:count, events_q)

Repo.all(
  from e in events_q,
    select: [e.time, e.value],
    order_by: [desc: e.time],
    limit: 10
)
```
