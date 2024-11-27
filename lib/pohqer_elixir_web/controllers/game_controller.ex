defmodule PohqerElixirWeb.GameController do
  use PohqerElixirWeb, :controller

  alias PohqerElixir.Games
  alias PohqerElixir.Games.{Round, Vote}

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"game" => game_params}) do
    case Games.create_game(Map.put(game_params, "status", "active")) do
      {:ok, game} ->
        # Create initial round
        {:ok, _round} =
          Games.create_round(%{
            game_id: game.id,
            status: "active",
            title: "Round 1"
          })

        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: ~p"/games/#{game.id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    current_round = Games.get_active_round(game.id)
    votes = if current_round, do: Games.list_votes_for_round(current_round.id), else: []
    render(conn, :show, game: game, current_round: current_round, votes: votes)
  end

  def create_round(conn, %{"game_id" => game_id, "round" => round_params}) do
    # First, close any active rounds
    if current_round = Games.get_active_round(game_id) do
      Games.update_round(current_round, %{status: "completed"})
    end

    # Create new round
    case Games.create_round(
           Map.merge(round_params, %{
             "game_id" => game_id,
             "status" => "active"
           })
         ) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "New round started successfully.")
        |> redirect(to: ~p"/games/#{game_id}")

      {:error, %Ecto.Changeset{}} ->
        conn
        |> put_flash(:error, "Error creating new round.")
        |> redirect(to: ~p"/games/#{game_id}")
    end
  end

  def finish_round(conn, %{"game_id" => game_id, "id" => round_id}) do
    round = Games.get_round!(round_id)

    case Games.update_round(round, %{status: "completed"}) do
      {:ok, _round} ->
        conn
        |> put_flash(:info, "Round finished successfully.")
        |> redirect(to: ~p"/games/#{game_id}")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Error finishing round.")
        |> redirect(to: ~p"/games/#{game_id}")
    end
  end

  def cast_vote(conn, %{
        "game_id" => game_id,
        "id" => round_id,
        "player_name" => player_name,
        "value" => value
      }) do
    case Games.create_vote(%{
           round_id: round_id,
           player_name: player_name,
           value: String.to_integer(value)
         }) do
      {:ok, _vote} ->
        conn
        |> put_flash(:info, "Vote cast successfully.")
        |> redirect(to: ~p"/games/#{game_id}")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, error_message_from_changeset(changeset))
        |> redirect(to: ~p"/games/#{game_id}")
    end
  end

  defp error_message_from_changeset(changeset) do
    Enum.map(changeset.errors, fn {field, {message, _opts}} ->
      "#{Phoenix.Naming.humanize(field)} #{message}"
    end)
    |> Enum.join(", ")
  end
end
