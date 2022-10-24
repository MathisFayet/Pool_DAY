defmodule PoolDay.Repo do
  use Ecto.Repo,
    otp_app: :poolDay,
    adapter: Ecto.Adapters.Postgres
end
