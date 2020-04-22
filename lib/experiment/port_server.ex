defmodule Experiment.PortServer do
  use Task, restart: :permanent

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_arg) do
    Enum.reduce(1..200, {[], []}, fn n, {ts, fs}->
      case System.cmd("ping", ["-c", "1", "192.168.0.#{n}"]) do
        {_, 0} -> {[n | ts], fs}
        _ -> {ts, [n | fs]}
      end
    end)
  end
end

