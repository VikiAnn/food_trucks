defmodule FoodTrucks.Repo do
  use Ecto.Repo,
    otp_app: :food_trucks,
    adapter: Ecto.Adapters.Postgres
end
