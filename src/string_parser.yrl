Terminals player_symbol.
Nonterminals request.
Rootsymbol request.

request -> player_symbol : extract_value('$1').
request -> player_symbol player_symbol : combine_values('$1', '$2').

Erlang code.

extract_value({_, _, Value}) ->
    Value.

combine_values({_, _, Value}, {_, _, Value2}) ->
    string:join([Value, Value2], " ").