defmodule WebServerCommunicatorTest do
  use ExUnit.Case
  doctest WebServerCommunicator


  #test "call with string command returns called string" do
  #  assert WebServerCommunicator.call_with_string("start_game(2,X,O)") === "called start_game"
  #end

  #test "call command returns called string for corresponding method signature with parameters" do
  #  assert WebServerCommunicator.call([:start_game, ["2", "X", "O"]]) === "{\"second_player_symbol\":\"O\",\"match_number\":\"2\",\"first_player_symbol\":\"X\"}"
  #  #%{match_number: "2", first_player_symbol: "X", second_player_symbol: "O"}
  #end

  test "generated JSON using Poison Library can be out of order" do
    assert WebServerCommunicator.generate_json(%{"age" => 27, "name" => "Test Pilot"}) === "{\"name\":\"Test Pilot\",\"age\":27}"
  end
end