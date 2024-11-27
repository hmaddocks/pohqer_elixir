defmodule PohqerElixirWeb.GameHTML.GameComponents do
  use PohqerElixirWeb, :html

  def game_header(assigns) do
    ~H"""
    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
      <div class="px-4 py-5 sm:px-6">
        <h1 class="text-2xl font-bold text-gray-900">Game #<%= @game.id %></h1>
        <p class="mt-1 max-w-2xl text-sm text-gray-500">
          Status: <%= @game.status %>
        </p>
      </div>
    </div>
    """
  end

  def round_header(assigns) do
    ~H"""
    <div class="bg-white shadow overflow-hidden sm:rounded-lg">
      <div class="px-4 py-5 sm:px-6">
        <h1 class="text-2xl font-bold text-gray-900">Round #<%= @current_round.id %></h1>
        <p class="mt-1 max-w-2xl text-sm text-gray-500">
          Status: <%= @current_round.status %>
          <.copy_link game={@game} round={@current_round} />
        </p>
      </div>
    </div>
    """
  end

  def copy_link(assigns) do
    ~H"""
    <div class="mt-4 flex items-center gap-4">
      <div class="relative flex-1">
        <input
          type="text"
          value={url(~p"/games/#{@game.id}")}
          readonly
          class="w-full px-3 py-2 border rounded bg-gray-50"
          id="game-url"
        />
      </div>
      <button
        class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
        onclick="navigator.clipboard.writeText(document.getElementById('game-url').value)"
      >
        Copy Link
      </button>
    </div>
    """
  end

  def voting_section(assigns) do
    ~H"""
    <div class="mb-6">
      <h3 class="text-lg font-semibold mb-2">Cast Your Vote</h3>
      <div class="grid grid-cols-4 gap-4 md:grid-cols-7">
        <%= for value <- [1, 2, 3, 5, 8, 13, 21] do %>
          <form
            action={~p"/games/#{@game.id}/rounds/#{@current_round.id}/vote"}
            method="post"
            class="inline"
          >
            <input type="hidden" name="player_name" value="Player 1" />
            <input type="hidden" name="value" value={value} />
            <button
              type="submit"
              class="w-full py-2 px-4 bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors"
            >
              <%= value %>
            </button>
          </form>
        <% end %>
      </div>
    </div>
    """
  end

  def round_results(assigns) do
    ~H"""
    <div class="mb-6">
      <h3 class="text-lg font-semibold mb-2">Round Results</h3>
      <div class="grid grid-cols-2 gap-4 md:grid-cols-3">
        <%= for vote <- @votes do %>
          <div class="p-4 bg-gray-100 rounded">
            <p class="font-semibold"><%= vote.player_name %></p>
            <p class="text-2xl"><%= vote.value %></p>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def new_round_form(assigns) do
    ~H"""
    <div class="mb-6">
      <.form :let={f} for={%{}} action={~p"/games/#{@game.id}/rounds"} method="post">
        <div class="flex gap-4">
          <div class="flex-1">
            <input
              type="text"
              name="round[title]"
              placeholder="Round Title"
              class="w-full px-3 py-2 border rounded"
            />
          </div>
          <button
            type="submit"
            class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition-colors"
          >
            Start New Round
          </button>
        </div>
      </.form>
    </div>
    """
  end

  def finish_round_button(assigns) do
    ~H"""
    <div class="mb-6">
      <.form
        :let={f}
        for={%{}}
        action={~p"/games/#{@game.id}/rounds/#{@current_round.id}/finish"}
        method="post"
      >
        <button
          type="submit"
          class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600 transition-colors"
        >
          Finish Round
        </button>
      </.form>
    </div>
    """
  end
end
