defmodule WebServerCommunicator do
#    def call_with_string(method_signature) do
#       apply(Elixir.WebServerCommunicator, :start_game, ["2", "X", "O"])
#    end

    def send_request(map) do
        if map.verb === "POST" do
            with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- post_request(generate_json(map), map.route)
            do
                body
            else
                {:error, %HTTPoison.Error{reason: reason}} ->
                reason
            end              
        end
    end

    def generate_json(map) do
        Poison.encode!(map)
    end

    def post_request(json, route) do
        HTTPoison.post "https://murmuring-coast-64789.herokuapp.com/game", json, [{"Content-Type", "application/json"}] 
    end
end