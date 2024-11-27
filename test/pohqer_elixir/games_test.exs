defmodule PohqerElixir.GamesTest do
  use PohqerElixir.DataCase

  alias PohqerElixir.Games

  describe "games" do
    alias PohqerElixir.Games.Game

    import PohqerElixir.GamesFixtures

    @invalid_attrs %{status: nil, title: nil, owner_name: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{status: "some status", title: "some title", owner_name: "some owner_name"}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.status == "some status"
      assert game.title == "some title"
      assert game.owner_name == "some owner_name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{status: "some updated status", title: "some updated title", owner_name: "some updated owner_name"}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.status == "some updated status"
      assert game.title == "some updated title"
      assert game.owner_name == "some updated owner_name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
