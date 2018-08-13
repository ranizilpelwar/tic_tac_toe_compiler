Terminals player_symbol.
Nonterminals command.
Rootsymbol command.

command -> player_symbol : extract_value('$1').
command -> player_symbol player_symbol : combine_values(extract_value('$1'), extract_value('$2')).

Erlang code.

extract_value({_, _, Value}) ->
    Value.

combine_values(Value, Value2) ->
    string:join([Value, Value2], " ").