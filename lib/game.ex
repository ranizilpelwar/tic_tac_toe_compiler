defmodule Game do
    def play do
        display_welcome_message()
        execute_command(%{statuses: %{game_over: false}})
    end

    def display_welcome_message do
        IO.puts "Welcome to Tic Tac Toe!"
    end

    def execute_command(map) do
        if (Map.has_key?(map, :timeout)) do
            IO.puts "Waking up web server"
            execute_command(map)
        end
        if (Map.has_key?(map, :statuses) && map.statuses.game_over === true) do
            show_end_game_results()
        else
            command = IO.gets "Enter a command:"
            command = String.trim(command)
            method = MethodParser.parse(command)
            request = MethodParser.call(method)
            game_state = WebServerCommunicator.send_request(request)
            IO.puts "\nTic Tac Toe Board:\n"
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
        "\n"
    end

    def format_board([head | tail]) do
        conditionally_display_vertical_bars([head | tail]) <> head <> conditionally_display_horizontal_bars(tail) <> format_board(tail)
    end

    def conditionally_display_vertical_bars(list) do
        if (Enum.member?([1,2,4,5,7,8], length(list))) do
            "|"
        else
            ""
        end
    end

    def conditionally_display_horizontal_bars(list) do
        if (length(list) == 3 || length(list) == 6) do
            "\n-+-+-\n"
        else
            ""
        end
    end
end