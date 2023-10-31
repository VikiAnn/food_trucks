defmodule FoodTrucks.SanFranEats.Vendor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vendors" do
    field :name, :string
    field :address, :string
    field :facility_type, :string
    field :location_description, :string
    field :permit_status, :string
    field :food_items, :string
    field :latitude, :float
    field :longitude, :float
    field :prior_permit, :boolean, default: false
    field :expiration, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vendor, attrs) do
    vendor
    |> cast(attrs, [
      :name,
      :facility_type,
      :location_description,
      :address,
      :permit_status,
      :food_items,
      :latitude,
      :longitude,
      :prior_permit,
      :expiration
    ])
    |> validate_required([
      :name,
      :address,
      :permit_status,
      :latitude,
      :longitude,
      :prior_permit
    ])
  end
end
