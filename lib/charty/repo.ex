defmodule Charty.Repo do
  use Ecto.Repo,
    otp_app: :charty,
    adapter: Ecto.Adapters.Postgres
end
