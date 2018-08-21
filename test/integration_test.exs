defmodule IntegrationTest do
    use ExUnit.Case
    doctest WebServerCommunicator
  
    test "start game command returns JSON" do
      assert MethodParser.parse("start game 2 X O")
                |> WebServerCommunicator.call()
                |> WebServerCommunicator.generate_json() === "{\"player2_symbol\":\"O\",\"player1_symbol\":\"X\",\"match_number\":\"2\"}"
                #"{\"match_number\":\"2\",\"player1_symbol\":\"X\",\"player2_symbol\":\"O\"}"
    end
end