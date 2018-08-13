defmodule StringParser do
    def parse(string) do
        with {:ok, tokens, _} <- :string_lexer.string(to_charlist(string)),
             {:ok, result} <- :string_parser.parse(tokens)
        do
            result
        else
            {:error, reason, _} ->
                reason
            {:error, {_, :string_parser, reason}} ->
                to_string(reason)
        end
    end

    def tokens(string) do
        :string_lexer.string(to_charlist(string))
    end
end