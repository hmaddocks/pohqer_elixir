defmodule PohqerElixir.Repo.Migrations.CreateRounds do
  use Ecto.Migration

  def change do
    create table(:rounds) do
      add :title, :string
      add :status, :string
      add :game_id, references(:games, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:rounds, [:game_id])
  end
end
