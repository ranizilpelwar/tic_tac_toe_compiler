Definitions.

KEYWORDS=null|true|false
SYMBOLS=[{}\[\]:,]
WHITESPACE=[\s\t\r\n]+
STRING="[^\"]+"
NUMBERS=[0-9]+
GAME_STATUS=(G|g)(A|a)(M|m)(E|e)(\s)(S|s)(T|t)(A|a)(T|t)(U|u)(S|s)
START_GAME=(S|s)(T|t)(A|a)(R|r)(T|t)(\s)(G|g)(A|a)(M|m)(E|e)
PLAYER_SYMBOL=(X|x|O|o)

Rules.

{STRING}             : {token, {string, TokenLine, extract_string(TokenChars)}}.
{KEYWORDS}           : {token, {list_to_atom(TokenChars), TokenLine}}.
{SYMBOLS}            : {token, {list_to_atom(TokenChars), TokenLine}}.
{NUMBERS}\.{NUMBERS} : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{NUMBERS}            : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{WHITESPACE}         : skip_token.
{GAME_STATUS}        : {token, {game_status, TokenLine, TokenChars}}.
{START_GAME}         : {token, {start_game, TokenLine, TokenChars}}.

Erlang code.

extract_string(Chars) ->
    list_to_binary(lists:sublist(Chars, 2, length(Chars) - 2)).
