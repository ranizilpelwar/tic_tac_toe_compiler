defmodule WebServerCommunicatorTest do
  use ExUnit.Case
  doctest WebServerCommunicator

  test "start game command returns called string" do
    assert WebServerCommunicator.start_game(2,X,O) === "called start_game"
  end

  test "call with string command returns called string" do
    assert WebServerCommunicator.call_with_string("start_game(2,X,O)") === "called start_game"
  end

  test "call command returns called string for corresponding method signature with parameters" do
    assert WebServerCommunicator.call([:start_game, ['2', 'X', 'O']]) === "called start_game with list"
  end
end