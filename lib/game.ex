defmodule Game do
    def play do
        display_welcome_message()
        execute_command(%{statuses: %{game_over: false}})
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
            method = MethodParser.parse(command)
            request = MethodParser.call(method)
            game_state = WebServerCommunicator.send_request(request)
            IO.puts "Tic Tac Toe Board:"
            board = game_state["game"]["board"]
            IO.puts format_board(board)
            execute_command(game_state)
            #game_state
        end
    end

    def show_end_game_results do
        IO.puts "Game Over"
    end

    def format_board(list) when length(list) == 0 do
        "|"
    end

    def format_board([head | tail]) do
        "|" <> head <> conditionally_display_horizontal_bars(tail) <> format_board(tail)
    end

    def conditionally_display_horizontal_bars(list) do
        if (length(list) == 3 || length(list) == 6) do
            "|\n+=+=+=+\n"
        else
            ""
        end
    end
end