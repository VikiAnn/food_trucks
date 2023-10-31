defmodule FoodTrucks.SanFranEats do
  @moduledoc """
  The SanFranEats context.
  """

  import Ecto.Query, warn: false
  alias FoodTrucks.Repo

  alias FoodTrucks.SanFranEats.Vendor

  @doc """
  Reads a CSV and returns a list of vendors.

  ## Examples

      iex> from_csv('filename.csv')
      [%Vendor{}, ...]

  """
  def from_csv(filename) do
    filename
    |> File.stream!(read_ahead: 100_000)
    |> CSV.decode(headers: true)
    |> Stream.map(&csv_row/1)
    |> Enum.to_list()
  end

  @doc """
  Returns the list of vendors.

  ## Examples

      iex> list_vendors()
      [%Vendor{}, ...]

  """
  def list_vendors do
    Repo.all(Vendor)
  end

  @doc """
  Gets a single vendor.

  Raises `Ecto.NoResultsError` if the Vendor does not exist.

  ## Examples

      iex> get_vendor!(123)
      %Vendor{}

      iex> get_vendor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vendor!(id), do: Repo.get!(Vendor, id)

  @doc """
  Creates a vendor.

  ## Examples

      iex> create_vendor(%{field: value})
      {:ok, %Vendor{}}

      iex> create_vendor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vendor(attrs \\ %{}) do
    %Vendor{}
    |> Vendor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vendor.

  ## Examples

      iex> update_vendor(vendor, %{field: new_value})
      {:ok, %Vendor{}}

      iex> update_vendor(vendor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vendor(%Vendor{} = vendor, attrs) do
    vendor
    |> Vendor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vendor.

  ## Examples

      iex> delete_vendor(vendor)
      {:ok, %Vendor{}}

      iex> delete_vendor(vendor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vendor(%Vendor{} = vendor) do
    Repo.delete(vendor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vendor changes.

  ## Examples

      iex> change_vendor(vendor)
      %Ecto.Changeset{data: %Vendor{}}

  """
  def change_vendor(%Vendor{} = vendor, attrs \\ %{}) do
    Vendor.changeset(vendor, attrs)
  end

  defp csv_row(
         {:ok,
          %{
            "Address" => address,
            "Applicant" => name,
            "ExpirationDate" => expiration,
            "FacilityType" => facility_type,
            "FoodItems" => food_items,
            "Latitude" => latitude,
            "Longitude" => longitude,
            "LocationDescription" => location_description,
            "PriorPermit" => prior_permit,
            "Status" => permit_status
          }}
       ) do
    change_vendor(%Vendor{}, %{
      "name" => name,
      "address" => address,
      "facility_type" => facility_type,
      "location_description" => location_description,
      "permit_status" => permit_status,
      "food_items" => food_items,
      "latitude" => latitude,
      "longitude" => longitude,
      "prior_permit" => prior_permit,
      "expiration" => expiration(expiration)
    })
  end

  defp expiration(date) when date in ["", nil], do: ""

  defp expiration(date) do
    [date | _] = String.split(date, " ")
    [month, day, year] = String.split(date, "/")
    "#{year}-#{month}-#{day} 00:00:00Z"
  end
end
