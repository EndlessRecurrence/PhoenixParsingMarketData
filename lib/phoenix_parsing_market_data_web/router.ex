defmodule PhoenixParsingMarketDataWeb.Router do
  use PhoenixParsingMarketDataWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixParsingMarketDataWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixParsingMarketDataWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/currencies", CurrencyController, :index
    get "/currencies/show/:id", CurrencyController, :show
    get "/currencies/:id/edit", CurrencyController, :edit
    get "/currencies/:first_id/:second_id/:first_date/:second_date", CurrencyController, :compare
    get "/currencies/new", CurrencyController, :new
    post "/currencies", CurrencyController, :create
    put "/currencies/:id", CurrencyController, :update
    delete "/currencies/:id", CurrencyController, :delete

    get "/values/:id/edit", ValueController, :edit
    put "/values/:id", ValueController, :update
  end

  scope "/api", PhoenixParsingMarketDataWeb do
    pipe_through :api
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:phoenix_parsing_market_data, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhoenixParsingMarketDataWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
