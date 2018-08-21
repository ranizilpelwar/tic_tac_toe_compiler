defmodule WebServerCommunicator do
    def call_with_string(method_signature) do
        apply(Elixir.WebServerCommunicator, :start_game, ["2", "X", "O"])
    end

    def call([command | parameters]) do
        apply(Elixir.WebServerCommunicator, command, parameters)
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

    def game_status(list) when length(list) == 0 do
        "called game_status with empty list"
    end

    def start_game_convert_params_list_to_map([match_number, player1_symbol, player2_symbol]) do
        %{match_number: match_number, player1_symbol: player1_symbol, player2_symbol: player2_symbol}
    end

    def generate_json(map) do
        Poison.encode!(map)
    end

    def send_request(json) do
        #get back a response JSON
    end
end