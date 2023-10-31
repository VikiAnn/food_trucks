# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FoodTrucks.Repo.insert!(%FoodTrucks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FoodTrucks.SanFranEats
alias FoodTrucks.Repo
alias FoodTrucks.SanFranEats.Vendor

Repo.delete_all(Vendor)

SanFranEats.from_csv(~c"priv/repo/seed_data/food_trucks.csv")
|> Enum.each(fn vendor_row -> Repo.insert!(vendor_row) end)
