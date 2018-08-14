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

    def start_game([_ | _]) do
        "called start_game with list" #executes the POST /game command on the web server
    end

    def game_status(list) when length(list) == 0 do
        "called game_status with empty list"
    end
end