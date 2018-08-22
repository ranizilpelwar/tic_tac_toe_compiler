defmodule WebServerCommunicator do
#    def call_with_string(method_signature) do
#       apply(Elixir.WebServerCommunicator, :start_game, ["2", "X", "O"])
#    end

    @url "https://murmuring-coast-64789.herokuapp.com/"

    def send_request(map) do
        with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- get_response(generate_json(map), map.verb, map.route)
        do
            Poison.Parser.parse!(body)
        else
            {:error, %HTTPoison.Error{reason: reason}} ->
            reason
        end              
    end

    def generate_json(map) do
        Poison.encode!(map)
    end

    def get_response(json, verb, route) do
        if verb === "POST" do
            HTTPoison.post @url <> route, json, [{"Content-Type", "application/json"}] 
        end
    end
end