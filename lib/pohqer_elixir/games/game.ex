defmodule PohqerElixir.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :status, :string
    field :title, :string
    field :owner_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:owner_name, :title, :status])
    |> validate_required([:owner_name, :title, :status])
  end
end
