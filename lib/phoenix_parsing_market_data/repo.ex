defmodule PhoenixParsingMarketData.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_parsing_market_data,
    adapter: Ecto.Adapters.Postgres
end
