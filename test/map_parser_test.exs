defmodule MapParserTest do
    use ExUnit.Case
    doctest MapParser

    test "start game command with parameters returns a list with method name as atom and a param list" do
        assert MapParser.parse("start game 2 X O") === [:start_game, %{match_number: '2', player1_symbol: 'X', player2_symbol: 'O'}]
    end

    test "game status command with no parameters returns a list with method name as atom and an empty param list" do
        assert MapParser.parse("game status") === [:game_status, []]
    end
end
  