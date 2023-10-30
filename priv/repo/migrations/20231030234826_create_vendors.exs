defmodule FoodTrucks.Repo.Migrations.CreateVendors do
  use Ecto.Migration

  def change do
    create table(:vendors) do
      add :name, :string
      add :facility_type, :string
      add :location_description, :string
      add :address, :string
      add :permit_status, :string
      add :food_items, :string
      add :latitude, :float
      add :longitude, :float
      add :prior_permit, :boolean, default: false, null: false
      add :expiration, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
