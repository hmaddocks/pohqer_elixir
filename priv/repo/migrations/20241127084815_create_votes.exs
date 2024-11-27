defmodule PohqerElixir.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :player_name, :string, null: false
      add :value, :integer, null: false
      add :round_id, references(:rounds, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:votes, [:round_id])
    create unique_index(:votes, [:round_id, :player_name], name: :round_id_player_name_unique_index)
  end
end
