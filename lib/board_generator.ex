defmodule BoardGenerator do

    def display_board(board) do
        IO.puts "\nTic Tac Toe Board:\n"
        IO.puts format_board(board)
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