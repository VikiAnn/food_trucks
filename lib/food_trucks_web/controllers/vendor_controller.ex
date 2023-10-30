defmodule FoodTrucksWeb.VendorController do
  use FoodTrucksWeb, :controller

  alias FoodTrucks.SanFranEats
  alias FoodTrucks.SanFranEats.Vendor

  def index(conn, _params) do
    vendors = SanFranEats.list_vendors()
    render(conn, :index, vendors: vendors)
  end

  def new(conn, _params) do
    changeset = SanFranEats.change_vendor(%Vendor{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"vendor" => vendor_params}) do
    case SanFranEats.create_vendor(vendor_params) do
      {:ok, vendor} ->
        conn
        |> put_flash(:info, "Vendor created successfully.")
        |> redirect(to: ~p"/vendors/#{vendor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    vendor = SanFranEats.get_vendor!(id)
    render(conn, :show, vendor: vendor)
  end

  def edit(conn, %{"id" => id}) do
    vendor = SanFranEats.get_vendor!(id)
    changeset = SanFranEats.change_vendor(vendor)
    render(conn, :edit, vendor: vendor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "vendor" => vendor_params}) do
    vendor = SanFranEats.get_vendor!(id)

    case SanFranEats.update_vendor(vendor, vendor_params) do
      {:ok, vendor} ->
        conn
        |> put_flash(:info, "Vendor updated successfully.")
        |> redirect(to: ~p"/vendors/#{vendor}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, vendor: vendor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    vendor = SanFranEats.get_vendor!(id)
    {:ok, _vendor} = SanFranEats.delete_vendor(vendor)

    conn
    |> put_flash(:info, "Vendor deleted successfully.")
    |> redirect(to: ~p"/vendors")
  end
end
