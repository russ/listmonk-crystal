require "http/client"
require "./endpoints/*"

module Listmonk
  class Client
    property http_client : HTTP::Client

    include Listmonk::Endpoints::Lists
    include Listmonk::Endpoints::Subscribers

    def initialize
      @http_client = configure_client
    end

    private def configure_client
      client = HTTP::Client.new(Listmonk.settings.host, Listmonk.settings.port)
      client.basic_auth(Listmonk.settings.username, Listmonk.settings.password)
      client
    end

    private def default_headers
      HTTP::Headers{
        "Content-Type" => "application/json;",
      }
    end

    private def get_request(path, headers : HTTP::Headers? = default_headers, query : String = "")
      @http_client.get(path + "?#{query}", headers: headers) do |response|
        process_response(response) do |results, errors|
          yield results, errors
        end
      end
    end

    private def post_request(path, request, headers : HTTP::Headers? = default_headers)
      @http_client.post(path, headers: headers, body: request.to_json) do |response|
        process_response(response) do |results, errors|
          yield results, errors
        end
      end
    end

    private def put_request(path, request = nil, headers : HTTP::Headers? = default_headers)
      @http_client.put(path, headers: headers) do |response|
        process_response(response) do |results, errors|
          yield results, errors
        end
      end
    end

    private def delete_request(path, headers : HTTP::Headers? = default_headers, query : String = "")
      @http_client.delete(path + "?#{query}", headers: headers) do |response|
        process_response(response) do |results, errors|
          yield results, errors
        end
      end
    end

    private def process_response(response)
      if body = response.body_io.gets
        if json_response = JSON.parse(body)
          yield json_response["data"]?, errors_on_response(json_response)
        end
      end
    end

    private def errors_on_response(response)
      if message = response["message"]?
        message.as_s
      end
    end
  end
end
