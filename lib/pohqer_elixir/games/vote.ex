defmodule PohqerElixir.Games.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :player_name, :string
    field :value, :integer
    belongs_to :round, PohqerElixir.Games.Round

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:player_name, :value, :round_id])
    |> validate_required([:player_name, :value, :round_id])
    |> validate_inclusion(:value, [1, 2, 3, 5, 8, 13, 21])
    |> foreign_key_constraint(:round_id)
    |> unique_constraint([:round_id, :player_name], message: "You have already voted in this round")
  end
end
