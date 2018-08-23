defmodule Game do
    def play do
        display_welcome_message()
        execute_command(%{statuses: %{game_over: false}})
    end

    def display_welcome_message do
        IO.puts "Welcome to Tic Tac Toe!"
    end

    def execute_command(map) do
        if (map === :timeout) do
            IO.puts "Waking up web server"
            execute_command(map)
        end
        if (Map.has_key?(map, :statuses) && map.statuses.game_over === true) do
            show_end_game_results()
        end
        if (Map.has_key?(map, "game") && is_computers_turn(map)) do
            play_as_computer(map)
        else
            get_human_input(map)
            #game_state
        end
    end

    def is_computers_turn(map) do
        if (map["game"]["match_number"] == 2 && map["game"]["current_player_symbol"] === map["game"]["player2_symbol"] 
            || map["game"]["match_number"] == 3) do
                true
            else
                false    
            end
    end

    def show_end_game_results do
        IO.puts "Game Over"
    end

    def combine_maps(old, new) do
        Map.merge(old, new, fn _k, v1, v2 -> v2 end)
    end

    def play_as_computer(request) do
        IO.puts "Playing computer's turn:" # add player symbol
        :timer.sleep(2000)
        action = %{verb: "PUT", route: "computer_players_turn"}
        display_updated_game_details(request, action)
    end

    def get_human_input(request) do
        command = IO.gets "Enter a command:"
        command = String.trim(command)
        method_with_arguments = MethodParser.parse(command)
        action = MethodParser.call(method_with_arguments)  
        display_updated_game_details(request, action)
    end

    def display_updated_game_details(map, action) do
        request = combine_maps(map, action)
        game_state = WebServerCommunicator.send_request(request) # new game state as a map
        BoardGenerator.display_board(game_state["game"]["board"])
        execute_command(game_state)
    end
end