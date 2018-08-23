defmodule MethodParser do
    def parse(string) do
        with {:ok, tokens, _} <- :string_lexer.string(to_charlist(string)),
             {:ok, result} <- :method_parser.parse(tokens)
        do
            result
        else
            {:error, reason, _} ->
                reason
            {:error, {_, :method_parser, reason}} ->
                to_string(reason)
        end
    end

    def tokens(string) do
        :string_lexer.string(to_charlist(string))
    end

    def call([command | parameters]) do
        apply(Elixir.MethodParser, command, parameters)
    end

    def start_game(match_number,player1_symbol,player2_symbol) do
        "called start_game" #executes the POST /game command on the web server
    end

    def start_game(list) when length(list) == 0 do
        "called start_game with empty list" #executes the POST /game command on the web server
    end

    def start_game(list) when length(list) == 3 do
        start_game_convert_params_list_to_map(list)
    end

    def place(list) do
        place_convert_params_list_to_map(list)
    end

    def game_status(list) when length(list) == 0 do
        "called game_status with empty list"
    end

    def start_game_convert_params_list_to_map([match_number, player1_symbol, player2_symbol]) do
        %{verb: "POST", route: "game", match_number: match_number, first_player_symbol: player1_symbol, second_player_symbol: player2_symbol}
    end

    def place_convert_params_list_to_map([player_symbol, tile]) do
        %{verb: "PUT", route: "human_players_turn", actions: %{tile_on_board: tile}}
    end
end