defmodule Experiment.Status do
  use Agent

  defmodule Status do
    defstruct counter: 0,
      times: 0
  end

  def start_link(_arg) do
    Agent.start_link(fn -> %Status{} end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1.counter)
  end

  def inc do
    Agent.update(__MODULE__, fn st -> Map.update(st, :counter, 0, &(&1 + 1)) end)
  end

  def times do
    Agent.get(__MODULE__, & &1.times)
  end

  def touch do
    Agent.update(__MODULE__, fn st -> Map.update(st, :times, 0, &(&1 + 1)) end)
  end
end
