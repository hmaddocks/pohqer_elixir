defmodule PohqerElixirWeb.GameHTML do
  use PohqerElixirWeb, :html

  import PohqerElixirWeb.GameHTML.GameComponents

  embed_templates "game_html/*"
end
