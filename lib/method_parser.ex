defmodule MethodParser do
    def parse(string) do
        with {:ok, tokens, _} <- :string_lexer.string(to_charlist(string)),
             {:ok, result} <- :method_parser.parse(tokens)
        do
            result
        else
            {:error, reason, _} ->
                reason
            {:error, {_, :method_parser, reason}} ->
                to_string(reason)
        end
    end

    def tokens(string) do
        :string_lexer.string(to_charlist(string))
    end
end