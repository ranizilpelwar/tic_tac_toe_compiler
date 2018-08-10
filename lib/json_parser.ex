defmodule JSONParser do
    def parse(string) do
        with {:ok, tokens, _} <- :json_lexer.string(to_charlist(string)),
             {:ok, result} <- :json_parser.parse(tokens)
        do
            result
        else
            {:error, reason, _} ->
                reason
            {:error, {_, :json_parser, reason}} ->
                to_string(reason)
        end
    end
end