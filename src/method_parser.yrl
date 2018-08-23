Terminals player_symbol command match_number tile_on_board. %% NOTE: name has to match atom from Lexer
Nonterminals request.
Rootsymbol request.

request -> match_number : extract_value('$1').
request -> player_symbol : extract_value('$1').
request -> player_symbol player_symbol : concat(extract_value('$1'), extract_value('$2')).
request -> command : [list_to_atom(method_name(extract_value('$1'))), empty_array()].
request -> command match_number player_symbol player_symbol : [list_to_atom(method_name(extract_value('$1'))), 
[extract_string_value('$2'), extract_string_value('$3'), extract_string_value('$4')]].
request -> command player_symbol tile_on_board : [list_to_atom(method_name(extract_value('$1'))), 
[extract_string_value('$2'), extract_string_value('$3')]].

Erlang code.

extract_value({_, _, Value}) ->
    Value.

extract_string_value({_, _, Value}) ->
    list_to_binary(Value).  

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

method_name_as_atom(Value) ->
    list_to_atom(method_name(Value)).

empty_array() ->
    [].