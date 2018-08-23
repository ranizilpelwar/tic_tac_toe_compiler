defmodule StringParserTest do
  use ExUnit.Case
  doctest StringParser

  test "start game command for Lexer returns list of tokens" do
    assert StringParser.tokens("start game") === {:ok, [{:command, 1, 'start game'}], 1}
  end

  test "start game command w match number for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2") === {:ok, [{:command, 1, 'start game'},
                                                          {:match_number, 1, '2'}],
                                                    1}
  end

  test "start game command w match number and player 1 symbol for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2 X") === {:ok, [{:command, 1, 'start game'}, 
                                                          {:match_number, 1, '2'},
                                                          {:player_symbol, 1, 'X'}
                                                         ],
                                                    1}
  end

  test "start game command w match number and both player symbols for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2 X O") === {:ok, [{:command, 1, 'start game'}, 
                                                          {:match_number, 1, '2'},
                                                          {:player_symbol, 1, 'X'}, 
                                                          {:player_symbol, 1, 'O'}
                                                         ],
                                                    1}
  end

  test "player symbol command for Parser returns symbol provided" do
    assert StringParser.parse("X") === 'X'
  end

  test "player symbol command for two symbols for Parser returns symbols provided" do
    assert StringParser.parse("X O") === 'X O'
  end

  test "match number command for Parser returns match number provided" do
    assert StringParser.parse("2") === '2'
  end

  test "start game command for Parser returns method name start_game" do
    assert StringParser.parse("start game") === 'start_game'
  end

  test "start game command with match number for Parser returns method name start_game and match number" do
    assert StringParser.parse("start game 2") === 'start_game 2'
  end

  test "start game command with match number and one player symbol for Parser returns method name and parameter values" do
    assert StringParser.parse("start game 2 X") === 'start_game 2 X'
  end

  test "start game command with match number and two player symbols for Parser returns method name and parameter values" do
    assert StringParser.parse("start game 2 X O") === 'start_game(2,X,O)'
  end

  test "game status command for Parser returns method name game_status" do
    assert StringParser.parse("game status") === 'game_status'
  end

  test "human player move command to Lexer returns list of tokens" do
    assert StringParser.tokens("play X at tile 5") ===  {:ok, [{:command, 1, 'play'}, 
                                                                {:player_symbol, 1, 'X'},
                                                                {:tile_on_board, 1, '5'}
                                                               ],
                                                          1}
  end
end
