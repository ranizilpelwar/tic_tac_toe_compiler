Terminals '{' '}' '[' ']' ':' ',' null true false string int float game_status start_game.
Nonterminals value array array_elements object key_value_pairs key_value_pair.
Rootsymbol value.

value -> 
    null : nil.
value ->
    true : true.
value -> 
    false : false.
value -> 
    string : extract_value('$1').
value ->
    int : extract_value('$1').
value ->
    float : extract_value('$1').
value ->
    array : '$1'.
value ->
    object : '$1'.
value ->
    game_status : ["PUT", extract_value('$1')].
value ->
    start_game : ["POST", extract_value('$1')].
value ->
    start_game int : ["POST", extract_value('$1'), extract_value('$2')].
value ->
    start_game int string : ["POST", extract_value('$1'), extract_value('$2'), extract_value('$3')].
array ->
    '[' array_elements ']' : '$2'.
array ->
    '[' ']' : [].
array_elements ->
    value ',' array_elements : ['$1' | '$3'].
array_elements ->
    value : ['$1'].
object ->
    '{' key_value_pairs '}' : '$2'.
object -> 
    '{' '}' : [].
key_value_pairs ->
    key_value_pair ',' key_value_pairs : ['$1' | '$3'].
key_value_pairs ->
    key_value_pair : ['$1'].
key_value_pair ->
    string ':' value : {binary_to_atom(extract_value('$1'), utf8), '$3'}. 

Erlang code.

extract_value({_, _, Value}) ->
    Value.
