defmodule PohqerElixirWeb.Router do
  use PohqerElixirWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PohqerElixirWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PohqerElixirWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/games/new", GameController, :new
    post "/games", GameController, :create
    get "/games/:id", GameController, :show
    post "/games/:game_id/rounds", GameController, :create_round
    post "/games/:game_id/rounds/:id/finish", GameController, :finish_round
    post "/games/:game_id/rounds/:id/vote", GameController, :cast_vote
  end

  # Other scopes may use custom stacks.
  # scope "/api", PohqerElixirWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:pohqer_elixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PohqerElixirWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
