defmodule MethodParserTest do
    use ExUnit.Case
    doctest MethodParser

    test "start game command with parameters returns a list with method name as atom and a param list" do
        assert MethodParser.parse("start game 2 X O") === [:start_game, ["2", "X", "O"]]
    end

    test "game status command with no parameters returns a list with method name as atom and an empty param list" do
        assert MethodParser.parse("game status") === [:game_status, []]
    end

    test "start game command returns called string" do
        assert MethodParser.start_game(2,X,O) === "called start_game"
    end
end
  