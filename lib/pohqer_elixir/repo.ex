defmodule PohqerElixir.Repo do
  use Ecto.Repo,
    otp_app: :pohqer_elixir,
    adapter: Ecto.Adapters.SQLite3
end
