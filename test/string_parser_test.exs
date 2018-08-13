defmodule StringParserTest do
  use ExUnit.Case
  doctest StringParser

  test "start game command for Lexer returns list of tokens" do
    assert StringParser.tokens("start game") === {:ok, [{:command, 1, 'start game'}], 1}
  end

  test "start game command w match number for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2") === {:ok, [{:command, 1, 'start game'},
                                                          {:match_number, 1, 2}],
                                                    1}
  end

  test "start game command w match number and player 1 symbol for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2 X") === {:ok, [{:command, 1, 'start game'}, 
                                                          {:match_number, 1, 2},
                                                          {:player_symbol, 1, 'X'}
                                                         ],
                                                    1}
  end

  test "start game command w match number and both player symbols for Lexer returns list of tokens" do
    assert StringParser.tokens("start game 2 X O") === {:ok, [{:command, 1, 'start game'}, 
                                                          {:match_number, 1, 2},
                                                          {:player_symbol, 1, 'X'}, 
                                                          {:player_symbol, 1, 'O'}
                                                         ],
                                                    1}
  end

  test "player symbol command for Parser returns symbol provided" do
    assert StringParser.parse("X") === 'X'
  end
end
