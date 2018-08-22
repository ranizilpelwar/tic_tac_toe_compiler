defmodule WebServerCommunicatorTest do
  use ExUnit.Case
  doctest WebServerCommunicator

  test "generated JSON using Poison Library can be out of order" do
    assert WebServerCommunicator.generate_json(%{"age" => 27, "name" => "Test Pilot"}) === "{\"name\":\"Test Pilot\",\"age\":27}"
  end
end