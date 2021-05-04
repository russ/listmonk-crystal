module Listmonk
  module Endpoints
    module Lists
      def all_lists(page : Int32 = 1, per_page : Int32 = 20, &block) : Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::List))?
        params = {
          "page"     => page.to_s,
          "per_page" => per_page.to_s,
        }

        get_request("/api/lists", query: URI::Params.encode(params)) do |response, errors|
          if response.nil?
            yield nil, errors
          else
            response["results"]?
            yield Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::List)).from_json(response.to_json), nil
          end
        end
      end

      def all_lists(page : Int32 = 1, per_page : Int32 = 20) : Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::List))?
        all_lists { }
      end
    end
  end
end
