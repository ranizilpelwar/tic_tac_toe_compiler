Terminals player_symbol command match_number.
Nonterminals request.
Rootsymbol request.

request -> match_number : extract_value('$1').
request -> player_symbol : extract_value('$1').
request -> player_symbol player_symbol : concat(extract_value('$1'), extract_value('$2')).
request -> command : [list_to_atom(method_name(extract_value('$1'))), empty_array()].
request -> command match_number player_symbol player_symbol : [list_to_atom(method_name(extract_value('$1'))), 
[extract_value('$2'), extract_value('$3'), extract_value('$4')]].

Erlang code.

extract_value({_, _, Value}) ->
    Value.

concat(Value, Value2) ->
    string:join([Value, Value2], " ").

merge(Value, Value2) ->
    string:join([Value, Value2], "").

parameterize(Value, Value2, Value3) ->
    string:join([Value, Value2, Value3], ",").

wrap(Value, Value2, Value3) ->
    merge(merge("(", parameterize(Value, Value2, Value3)), ")").

method_name(Value) ->
    string:join(string:tokens(Value, " "), "_").

start_game_signature({_, _, Command}, {_, _, Match_Number}, {_, _, Player1_Symbol}, {_, _, Player2_Symbol}) ->
    merge(method_name(Command), wrap(Match_Number, Player1_Symbol, Player2_Symbol)).

method_name_as_atom(Value) ->
    list_to_atom(method_name(Value)).

empty_array() ->
    [].