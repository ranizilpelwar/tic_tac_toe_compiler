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
            command = String.trim(command)          # "start game 2 X O"
            method_with_arguments = MethodParser.parse(command)    # :start_game, ["2", "X", "O"]
            request = MethodParser.call(method_with_arguments)     # %{statuses: %{game_over: false}}  
            game_state = WebServerCommunicator.send_request(request) # new game state as a map
            BoardGenerator.display_board(game_state["game"]["board"])
            execute_command(game_state)
            #game_state
        end
    end

    def show_end_game_results do
        IO.puts "Game Over"
    end

end