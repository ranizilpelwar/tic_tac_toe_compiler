defmodule MapParser do
    def parse(string) do
        with {:ok, tokens, _} <- :string_lexer.string(to_charlist(string)),
             {:ok, result} <- :map_parser.parse(tokens)
        do
            result
        else
            {:error, reason, _} ->
                reason
            {:error, {_, :map_parser, reason}} ->
                to_string(reason)
        end
    end

    def tokens(string) do
        :string_lexer.string(to_charlist(string))
    end
end