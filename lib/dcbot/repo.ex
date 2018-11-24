defmodule Dcbot.Repo do
  use Ecto.Repo,
    otp_app: :dcbot,
    adapter: Ecto.Adapters.Postgres
end
