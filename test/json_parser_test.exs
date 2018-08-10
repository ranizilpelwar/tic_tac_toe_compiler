defmodule JSONParserTest do
  use ExUnit.Case
  doctest JSONParser

  test "JSON returns K V pair as a list of an atom and value" do
    assert JSONParser.parse(~s({"game": "state"})) === [game: "state"]
  end

  test "JSON with a subnest returns K V pair as a list of a list of an atom and value" do
    assert JSONParser.parse(~s({"game": {"language": "tag"}})) === [game: [language: "tag"]]
  end

  test "game_status command for Parser returns PUT in a list" do
    assert JSONParser.parse("game status") === ['PUT', 'game status']
  end

  test "start game command for Parser returns POST in a KV pair" do
    assert JSONParser.parse("start game") === ['POST', 'start game']
  end
end
