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
            yield Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::List)).from_json(response.to_json), nil
          end
        end
      end

      def all_lists(page : Int32 = 1, per_page : Int32 = 20) : Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::List))?
        all_lists { }
      end

      def fetch_list(list_id : Int32) : Listmonk::Types::List?
        get_request("/api/lists/#{list_id}") do |response, errors|
          if response
            yield Listmonk::Types::List.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def fetch_list(list_id : Int32) : Listmonk::Types::List?
        fetch_list(list_id) { }
      end

      def create_list(request : Listmonk::Types::ListRequest, &block) : Listmonk::Types::List?
        post_request("/api/lists", request) do |response, errors|
          if response
            yield Listmonk::Types::List.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def create_list(request : Listmonk::Types::ListRequest) : Listmonk::Types::List?
        create_list(request) { }
      end

      def update_list(list_id : Int32, request : Listmonk::Types::ListRequest, &block) : Listmonk::Types::List?
        put_request("/api/lists/#{list_id}", request) do |response, errors|
          if response
            yield Listmonk::Types::List.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def update_list(list_id : Int32, request : Listmonk::Types::ListRequest) : Listmonk::Types::List?
        update_list(list_id, request) { }
      end

      def delete_list(list_id : Int32, &block) : Listmonk::Types::GenericResponse?
        delete_request("/api/lists/#{list_id}") do |response, errors|
          if response
            yield Listmonk::Types::GenericResponse.new(success: response.as_bool), nil
          else
            yield nil, errors
          end
        end
      end

      def delete_list(list_id : Int32) : Listmonk::Types::GenericResponse?
        delete_list(list_id) { }
      end
    end
  end
end
