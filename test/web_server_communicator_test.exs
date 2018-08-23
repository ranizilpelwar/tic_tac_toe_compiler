defmodule WebServerCommunicatorTest do
  use ExUnit.Case
  doctest WebServerCommunicator

  test "generated JSON using Poison Library can be out of order" do
    assert WebServerCommunicator.generate_json(%{"age" => 27, "name" => "Test Pilot"}) === "{\"name\":\"Test Pilot\",\"age\":27}"
  end

  test "generated JSON for human player move converts to correct nested JSON object" do
    assert WebServerCommunicator.generate_json(%{route: "human_players_turn", verb: "PUT", actions: %{tile_on_board: "5"}}) === "{\"verb\":\"PUT\",\"route\":\"human_players_turn\",\"actions\":{\"tile_on_board\":\"5\"}}"
  end

  test "get_response returns initial game state when POST game is requested" do
    map = %{verb: "POST", route: "game", match_number: "2", first_player_symbol: "X", second_player_symbol: "O"}
    json = WebServerCommunicator.generate_json(map)
    {:ok, %HTTPoison.Response{body: body, status_code: 200}} = WebServerCommunicator.get_response(json, map.verb, map.route)
    assert Poison.Parser.parse!(body) === %{"errors" => %{"error_message" => "", "stack_trace" => ""}, 
                                            "game" => %{"board" => ["1", "2", "3", "4", "5", "6", "7", "8", "9"], 
                                            "current_player_symbol" => "X", 
                                            "language_tag" => "en", 
                                            "last_move_for_player1" => -1, 
                                            "last_move_for_player2" => -1, 
                                            "match_number" => 2, 
                                            "player1_symbol" => "X", 
                                            "player2_symbol" => "O", 
                                            "record_moves" => true}}
  end
end