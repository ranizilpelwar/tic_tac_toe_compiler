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

    test "combining maps of differing keys results in a consolidated map" do
      map1 = %{statuses: %{game_over: false}}
      map2 = %{verb: "POST", route: "game", match_number: "2", first_player_symbol: "X", second_player_symbol: "O"}
      assert Game.combine_maps(map1, map2) === %{
                                                  first_player_symbol: "X",
                                                  match_number: "2",
                                                  route: "game",
                                                  second_player_symbol: "O",
                                                  statuses: %{game_over: false},
                                                  verb: "POST"
                                                }
    end

    test "combining maps of overlapping keys results in a consolidated map containing values from second map" do
      map1 = %{statuses: %{game_over: false}}
      map2 = %{verb: "POST", route: "game", match_number: "2", first_player_symbol: "X", second_player_symbol: "O", statuses: %{game_over: true}}
      assert Game.combine_maps(map1, map2) === %{
                                                  first_player_symbol: "X",
                                                  match_number: "2",
                                                  route: "game",
                                                  second_player_symbol: "O",
                                                  statuses: %{game_over: true},
                                                  verb: "POST"
                                                }
    end
end