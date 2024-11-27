defmodule PohqerElixir.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :owner_name, :string
      add :title, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
