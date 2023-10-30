defmodule FoodTrucks.SanFranEatsTest do
  use FoodTrucks.DataCase

  alias FoodTrucks.SanFranEats

  describe "vendors" do
    alias FoodTrucks.SanFranEats.Vendor

    import FoodTrucks.SanFranEatsFixtures

    @invalid_attrs %{name: nil, address: nil, facility_type: nil, location_description: nil, permit_status: nil, food_items: nil, latitude: nil, longitude: nil, prior_permit: nil, expiration: nil}

    test "list_vendors/0 returns all vendors" do
      vendor = vendor_fixture()
      assert SanFranEats.list_vendors() == [vendor]
    end

    test "get_vendor!/1 returns the vendor with given id" do
      vendor = vendor_fixture()
      assert SanFranEats.get_vendor!(vendor.id) == vendor
    end

    test "create_vendor/1 with valid data creates a vendor" do
      valid_attrs = %{name: "some name", address: "some address", facility_type: "some facility_type", location_description: "some location_description", permit_status: "some permit_status", food_items: "some food_items", latitude: 120.5, longitude: 120.5, prior_permit: true, expiration: ~N[2023-10-29 23:48:00]}

      assert {:ok, %Vendor{} = vendor} = SanFranEats.create_vendor(valid_attrs)
      assert vendor.name == "some name"
      assert vendor.address == "some address"
      assert vendor.facility_type == "some facility_type"
      assert vendor.location_description == "some location_description"
      assert vendor.permit_status == "some permit_status"
      assert vendor.food_items == "some food_items"
      assert vendor.latitude == 120.5
      assert vendor.longitude == 120.5
      assert vendor.prior_permit == true
      assert vendor.expiration == ~N[2023-10-29 23:48:00]
    end

    test "create_vendor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SanFranEats.create_vendor(@invalid_attrs)
    end

    test "update_vendor/2 with valid data updates the vendor" do
      vendor = vendor_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", facility_type: "some updated facility_type", location_description: "some updated location_description", permit_status: "some updated permit_status", food_items: "some updated food_items", latitude: 456.7, longitude: 456.7, prior_permit: false, expiration: ~N[2023-10-30 23:48:00]}

      assert {:ok, %Vendor{} = vendor} = SanFranEats.update_vendor(vendor, update_attrs)
      assert vendor.name == "some updated name"
      assert vendor.address == "some updated address"
      assert vendor.facility_type == "some updated facility_type"
      assert vendor.location_description == "some updated location_description"
      assert vendor.permit_status == "some updated permit_status"
      assert vendor.food_items == "some updated food_items"
      assert vendor.latitude == 456.7
      assert vendor.longitude == 456.7
      assert vendor.prior_permit == false
      assert vendor.expiration == ~N[2023-10-30 23:48:00]
    end

    test "update_vendor/2 with invalid data returns error changeset" do
      vendor = vendor_fixture()
      assert {:error, %Ecto.Changeset{}} = SanFranEats.update_vendor(vendor, @invalid_attrs)
      assert vendor == SanFranEats.get_vendor!(vendor.id)
    end

    test "delete_vendor/1 deletes the vendor" do
      vendor = vendor_fixture()
      assert {:ok, %Vendor{}} = SanFranEats.delete_vendor(vendor)
      assert_raise Ecto.NoResultsError, fn -> SanFranEats.get_vendor!(vendor.id) end
    end

    test "change_vendor/1 returns a vendor changeset" do
      vendor = vendor_fixture()
      assert %Ecto.Changeset{} = SanFranEats.change_vendor(vendor)
    end
  end
end
