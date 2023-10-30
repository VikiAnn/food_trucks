defmodule FoodTrucksWeb.VendorControllerTest do
  use FoodTrucksWeb.ConnCase

  import FoodTrucks.SanFranEatsFixtures

  @create_attrs %{name: "some name", address: "some address", facility_type: "some facility_type", location_description: "some location_description", permit_status: "some permit_status", food_items: "some food_items", latitude: 120.5, longitude: 120.5, prior_permit: true, expiration: ~N[2023-10-29 23:48:00]}
  @update_attrs %{name: "some updated name", address: "some updated address", facility_type: "some updated facility_type", location_description: "some updated location_description", permit_status: "some updated permit_status", food_items: "some updated food_items", latitude: 456.7, longitude: 456.7, prior_permit: false, expiration: ~N[2023-10-30 23:48:00]}
  @invalid_attrs %{name: nil, address: nil, facility_type: nil, location_description: nil, permit_status: nil, food_items: nil, latitude: nil, longitude: nil, prior_permit: nil, expiration: nil}

  describe "index" do
    test "lists all vendors", %{conn: conn} do
      conn = get(conn, ~p"/vendors")
      assert html_response(conn, 200) =~ "Listing Vendors"
    end
  end

  describe "new vendor" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/vendors/new")
      assert html_response(conn, 200) =~ "New Vendor"
    end
  end

  describe "create vendor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/vendors", vendor: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/vendors/#{id}"

      conn = get(conn, ~p"/vendors/#{id}")
      assert html_response(conn, 200) =~ "Vendor #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/vendors", vendor: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Vendor"
    end
  end

  describe "edit vendor" do
    setup [:create_vendor]

    test "renders form for editing chosen vendor", %{conn: conn, vendor: vendor} do
      conn = get(conn, ~p"/vendors/#{vendor}/edit")
      assert html_response(conn, 200) =~ "Edit Vendor"
    end
  end

  describe "update vendor" do
    setup [:create_vendor]

    test "redirects when data is valid", %{conn: conn, vendor: vendor} do
      conn = put(conn, ~p"/vendors/#{vendor}", vendor: @update_attrs)
      assert redirected_to(conn) == ~p"/vendors/#{vendor}"

      conn = get(conn, ~p"/vendors/#{vendor}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, vendor: vendor} do
      conn = put(conn, ~p"/vendors/#{vendor}", vendor: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Vendor"
    end
  end

  describe "delete vendor" do
    setup [:create_vendor]

    test "deletes chosen vendor", %{conn: conn, vendor: vendor} do
      conn = delete(conn, ~p"/vendors/#{vendor}")
      assert redirected_to(conn) == ~p"/vendors"

      assert_error_sent 404, fn ->
        get(conn, ~p"/vendors/#{vendor}")
      end
    end
  end

  defp create_vendor(_) do
    vendor = vendor_fixture()
    %{vendor: vendor}
  end
end
