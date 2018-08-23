defmodule WebServerCommunicatorTest do
  use ExUnit.Case
  doctest WebServerCommunicator

  test "generated JSON using Poison Library can be out of order" do
    assert WebServerCommunicator.generate_json(%{"age" => 27, "name" => "Test Pilot"}) === "{\"name\":\"Test Pilot\",\"age\":27}"
  end

  test "generated JSON for human player move converts to correct nested JSON object" do
    assert WebServerCommunicator.generate_json(%{route: "human_players_turn", verb: "PUT", actions: %{tile_on_board: "5"}}) === "{\"verb\":\"PUT\",\"route\":\"human_players_turn\",\"actions\":{\"tile_on_board\":\"5\"}}"
  end
end