defmodule Game do
    def play do
        display_welcome_message()
        execute_command(%{statuses: %{game_over: true}})
    end

    def display_welcome_message do
        IO.puts "Welcome to Tic Tac Toe!"
    end

    def execute_command(map) do
        if (Map.has_key?(map, :statuses) && map.statuses.game_over === true) do
            show_end_game_results()
        else
            command = IO.gets "Enter a command:"
            command = String.trim(command)
            MethodParser.parse(command)
                |> MethodParser.call()
                |> WebServerCommunicator.send_request()
                |> execute_command()
        end
    end

    def show_end_game_results do
        IO.puts "Game Over"
    end
end