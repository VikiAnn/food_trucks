defmodule FoodTrucks.SanFranEatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTrucks.SanFranEats` context.
  """

  @doc """
  Generate a vendor.
  """
  def vendor_fixture(attrs \\ %{}) do
    {:ok, vendor} =
      attrs
      |> Enum.into(%{
        address: "some address",
        expiration: ~N[2023-10-29 23:48:00],
        facility_type: "some facility_type",
        food_items: "some food_items",
        latitude: 120.5,
        location_description: "some location_description",
        longitude: 120.5,
        name: "some name",
        permit_status: "some permit_status",
        prior_permit: true
      })
      |> FoodTrucks.SanFranEats.create_vendor()

    vendor
  end
end
