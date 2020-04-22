defmodule ExperimentTest do
  use ExUnit.Case
  doctest Experiment

  alias Communication.Crc16
  alias Communication.CheckSum

  test "CRC16" do
    assert Crc16.calc("qwertyiop") == <<78, 235>>
  end
end
