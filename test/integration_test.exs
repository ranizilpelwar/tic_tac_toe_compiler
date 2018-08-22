defmodule IntegrationTest do
    use ExUnit.Case
    doctest WebServerCommunicator
  
    test "start game command returns initial game state in response" do
      assert MethodParser.parse("start game 2 X O")
                |> MethodParser.call()
                |> WebServerCommunicator.send_request() === %{
                    "errors" => %{"error_message" => "", "stack_trace" => ""},
                    "game" => %{
                      "board" => ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
                      "current_player_symbol" => "X",
                      "language_tag" => "en",
                      "last_move_for_player1" => -1,
                      "last_move_for_player2" => -1,
                      "match_number" => 2,
                      "player1_symbol" => "X",
                      "player2_symbol" => "O",
                      "record_moves" => true
                    }
                  }
    end
end