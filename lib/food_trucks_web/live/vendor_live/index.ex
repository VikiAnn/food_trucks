defmodule FoodTrucksWeb.VendorLive.Index do
  use FoodTrucksWeb, :live_view

  alias FoodTrucks.SanFranEats
  alias FoodTrucks.SanFranEats.Vendor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vendors, SanFranEats.list_vendors())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Vendor")
    |> assign(:vendor, SanFranEats.get_vendor!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Vendor")
    |> assign(:vendor, %Vendor{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vendors")
    |> assign(:vendor, nil)
  end

  @impl true
  def handle_info({FoodTrucksWeb.VendorLive.FormComponent, {:saved, vendor}}, socket) do
    {:noreply, stream_insert(socket, :vendors, vendor)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    vendor = SanFranEats.get_vendor!(id)
    {:ok, _} = SanFranEats.delete_vendor(vendor)

    {:noreply, stream_delete(socket, :vendors, vendor)}
  end

  def handle_event("after_render", _, socket) do
    vendors = SanFranEats.list_vendors()

    markers =
      Enum.map(vendors, fn %{latitude: latitude, longitude: longitude} ->
        %{latitude: latitude, longitude: longitude}
      end)

    socket =
      push_event(socket, "vendorMarkers", %{markers: markers})

    {:noreply, socket}
  end
end
