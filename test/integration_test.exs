defmodule IntegrationTest do
    use ExUnit.Case
    doctest WebServerCommunicator
  
    test "start game command returns JSON response" do
      assert MethodParser.parse("start game 2 X O")
                |> MethodParser.call() #dynamically finds the method to call and they all return a map
                |> WebServerCommunicator.send_request() === "{\"game\":{\"language_tag\":\"en\",\"match_number\":2,\"player1_symbol\":\"X\",\"player2_symbol\":\"O\",\"current_player_symbol\":\"X\",\"board\":[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\"],\"record_moves\":true,\"last_move_for_player1\":-1,\"last_move_for_player2\":-1},\"errors\":{\"error_message\":\"\",\"stack_trace\":\"\"}}"
    end
end