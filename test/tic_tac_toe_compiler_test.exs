defmodule TicTacToeCompilerTest do
  use ExUnit.Case
  doctest TicTacToeCompiler

  test "start_game command returns a POST" do
    assert TicTacToeCompiler.convert("start_game 2 X O") == "POST /game '{\"match_number\":2,\"first_player_symbol\":\"X\",\"second_player_symbol\":\"Y\"}'"
  end

  test "game_status command returns a PUT" do
    assert TicTacToeCompiler.convert("game_status") == "PUT /game_status '{\"game\": {
      \"language_tag\": \"en\",
      \"match_number\": 2,
      \"player1_symbol\": \"X\", 
      \"player2_symbol\": \"Y\",
      \"current_player_symbol\": \"X\",
      \"board\": [\"X\", \"X\", \"O\", \"O\", \"O\", \"X\", \"X\", \"O\", \"X\"],
      \"record_moves\": false,
      \"last_move_for_player1\":-1,
      \"last_move_for_player2\":-1},\"actions\": {\"tile_on_board\": \"5\"}}'"
  end
end
