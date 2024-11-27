defmodule PohqerElixir.Games.Round do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rounds" do
    field :title, :string
    field :status, :string
    belongs_to :game, PohqerElixir.Games.Game

    timestamps()
  end

  @doc false
  def changeset(round, attrs) do
    round
    |> cast(attrs, [:title, :status, :game_id])
    |> validate_required([:status, :game_id])
    |> foreign_key_constraint(:game_id)
  end
end
