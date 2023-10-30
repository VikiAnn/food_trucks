defmodule FoodTrucks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodTrucksWeb.Telemetry,
      FoodTrucks.Repo,
      {DNSCluster, query: Application.get_env(:food_trucks, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FoodTrucks.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FoodTrucks.Finch},
      # Start a worker by calling: FoodTrucks.Worker.start_link(arg)
      # {FoodTrucks.Worker, arg},
      # Start to serve requests, typically the last entry
      FoodTrucksWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodTrucks.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodTrucksWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
