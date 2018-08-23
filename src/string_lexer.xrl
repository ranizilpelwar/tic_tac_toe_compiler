Definitions.

WHITESPACE=[\s\t\r\n]+
GAME_STATUS=(G|g)(A|a)(M|m)(E|e)(\s)(S|s)(T|t)(A|a)(T|t)(U|u)(S|s)
START_GAME=(S|s)(T|t)(A|a)(R|r)(T|t)(\s)(G|g)(A|a)(M|m)(E|e)
PLAYER_SYMBOL=[^0-9\s]
BOARD_TILE=[1-9]
HUMAN_MOVE=(P|p)(L|l)(A|a)(C|c)(E|e)
TILE_MARKER=(A|a)(T|t)(\s)(T|t)(I|i)(L|l)(E|e)
COMMAND={GAME_STATUS}|{START_GAME}|{HUMAN_MOVE}
MATCH_NUMBER=[1-3]


Rules.

{COMMAND}            : {token, {list_to_atom("command"), TokenLine, TokenChars}}.
{PLAYER_SYMBOL}      : {token, {list_to_atom("player_symbol"), TokenLine, TokenChars}}.
{MATCH_NUMBER}       : {token, {list_to_atom("match_number"), TokenLine, TokenChars}}.
{BOARD_TILE}         : {token, {list_to_atom("tile_on_board"), TokenLine, TokenChars}}.
{WHITESPACE}         : skip_token.
{TILE_MARKER}        : skip_token.

Erlang code.

extract_string(Chars) ->
    list_to_binary(lists:sublist(Chars, 2, length(Chars) - 2)).
