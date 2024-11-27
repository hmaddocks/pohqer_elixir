defmodule PohqerElixir.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PohqerElixir.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        owner_name: "some owner_name",
        status: "some status",
        title: "some title"
      })
      |> PohqerElixir.Games.create_game()

    game
  end
end
