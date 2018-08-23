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

    test "start game call command will return a map containing the request details" do
        assert MethodParser.call([:start_game, ["2", "X", "O"]]) === %{verb: "POST", route: "game", match_number: "2", first_player_symbol: "X", second_player_symbol: "O"}
    end

    test "player move command to Lexer returns list of tokens" do
        assert MethodParser.tokens("place X at tile 5") ===  {:ok, [{:command, 1, 'place'}, 
                                                                {:player_symbol, 1, 'X'},
                                                                {:tile_on_board, 1, '5'}],
                                                        1}
    end

    test "player move command returns a list with method name as atom and an empty params list" do
        assert MethodParser.parse("place") === [:place, []]
    end

    test "player move command with player symbol and tile for Parser returns a list with method name as atom and a param list" do
        assert MethodParser.parse("place X at tile 5") === [:place, ["X", "5"]]
    end
    
    test "player move command will return a map containing the request details" do
        assert MethodParser.call([:place, ["X", "5"]]) === %{route: "human_players_turn", verb: "PUT", actions: %{tile_on_board: "5"}}
    end
end
  