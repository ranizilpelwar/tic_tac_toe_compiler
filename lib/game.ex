defmodule Game do
    def play do
        display_welcome_message()
        execute_command(%{statuses: %{game_over: false}})
    end

    def display_welcome_message do
        IO.puts "Welcome to Tic Tac Toe!"
    end

    def execute_command(game) do
        if (game === :timeout) do
            IO.puts "Waking up web server"
            execute_command(game)
        end
        if (is_game_over(game) === true) do
            show_end_game_results(game)
        else
            if (Map.has_key?(game, "game") && is_computers_turn(game)) do
                play_as_computer(game)
            else
                get_human_input(game)
                #game_state
            end
        end
    end

    def is_game_over(game) do
        if (Map.has_key?(game, "statuses") && game["statuses"]["game_over"] === true) do
            true
        else
            false
        end
    end

    def is_computers_turn(game) do
        if (game["game"]["match_number"] == 2 && game["game"]["current_player_symbol"] === game["game"]["player2_symbol"] 
            || game["game"]["match_number"] == 3) do
                true
            else
                false    
            end
    end

    def show_end_game_results(game) do
        IO.puts "Game Over!"
        if (game["statuses"]["tie_game"] === true) do
            IO.puts "No winners this time, it was a tie!"
        else
            winner = game["statuses"]["winner"]
            IO.puts "Congratulations to the winner, Player " <> winner <> "!"
        end
    end

    def combine_maps(old, new) do
        Map.merge(old, new, fn _k, v1, v2 -> v2 end)
    end

    def play_as_computer(game) do
        IO.puts "Playing computer's turn..." # add player symbol
        :timer.sleep(2000)
        action = %{verb: "PUT", route: "computer_players_turn"}
        display_updated_game_details(game, action)
    end

    def get_human_input(game) do
        command = IO.gets "Enter a command:"
        command = String.trim(command)
        method_with_arguments = MethodParser.parse(command)
        action = MethodParser.call(method_with_arguments)  
        display_updated_game_details(game, action)
    end

    def display_updated_game_details(game, action) do
        request = combine_maps(game, action)
        game_state = WebServerCommunicator.send_request(request) # new game state as a map
        BoardGenerator.display_board(game_state["game"]["board"])
        execute_command(game_state)
    end
end