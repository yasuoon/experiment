defmodule Experiment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Experiment.Worker.start_link(arg)
      # {Experiment.Worker, arg}
      {Experiment.Status, 0},
      {Plug.Cowboy, scheme: :http, plug: Experiment.Router, options: [port: 8080]},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Experiment.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end
end
