defmodule PohqerElixirWeb.GameController do
  use PohqerElixirWeb, :controller

  def new(conn, _params) do
    render(conn, :new)
  end

  def create(conn, %{"game" => game_params}) do
    # We'll implement this later when we have the Game context
    # For now, we'll just redirect to the home page
    conn
    |> put_flash(:info, "Game created successfully.")
    |> redirect(to: ~p"/")
  end
end
