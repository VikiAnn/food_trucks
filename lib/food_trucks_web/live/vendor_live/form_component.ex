defmodule FoodTrucksWeb.VendorLive.FormComponent do
  use FoodTrucksWeb, :live_component

  alias FoodTrucks.SanFranEats

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage vendor records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="vendor-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:facility_type]} type="text" label="Facility type" />
        <.input field={@form[:location_description]} type="text" label="Location description" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:permit_status]} type="text" label="Permit status" />
        <.input field={@form[:food_items]} type="text" label="Food items" />
        <.input field={@form[:latitude]} type="number" label="Latitude" step="any" />
        <.input field={@form[:longitude]} type="number" label="Longitude" step="any" />
        <.input field={@form[:prior_permit]} type="checkbox" label="Prior permit" />
        <.input field={@form[:expiration]} type="datetime-local" label="Expiration" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Vendor</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{vendor: vendor} = assigns, socket) do
    changeset = SanFranEats.change_vendor(vendor)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"vendor" => vendor_params}, socket) do
    changeset =
      socket.assigns.vendor
      |> SanFranEats.change_vendor(vendor_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"vendor" => vendor_params}, socket) do
    save_vendor(socket, socket.assigns.action, vendor_params)
  end

  defp save_vendor(socket, :edit, vendor_params) do
    case SanFranEats.update_vendor(socket.assigns.vendor, vendor_params) do
      {:ok, vendor} ->
        notify_parent({:saved, vendor})

        {:noreply,
         socket
         |> put_flash(:info, "Vendor updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_vendor(socket, :new, vendor_params) do
    case SanFranEats.create_vendor(vendor_params) do
      {:ok, vendor} ->
        notify_parent({:saved, vendor})

        {:noreply,
         socket
         |> put_flash(:info, "Vendor created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
