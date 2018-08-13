Terminals player_symbol.
Nonterminals command.
Rootsymbol command.

command -> player_symbol : extract_value('$1').

Erlang code.

extract_value({_, _, Value}) ->
    Value.
