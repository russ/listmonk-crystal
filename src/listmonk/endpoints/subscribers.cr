module Listmonk
  module Endpoints
    module Subscribers
      def all_subscribers(page : Int32 = 1, per_page : Int32 = 20, query : String? = nil, &block)
        params = {
          "page"     => page.to_s,
          "per_page" => per_page.to_s,
          "query"    => query.to_s,
        }

        get_request("/api/subscribers", query: URI::Params.encode(params)) do |response, errors|
          if response
            yield Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::Subscriber)).from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def all_subscribers(page : Int32 = 1, per_page : Int32 = 20, query : String? = nil)
        all_subscribers(page, per_page, query) { }
      end

      def fetch_subscriber(subscriber_id : Int32, &block) : Listmonk::Types::Subscriber?
        get_request("/api/subscribers/#{subscriber_id}") do |response, errors|
          if response
            yield Listmonk::Types::Subscriber.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def fetch_subscriber(subscriber_id : Int32) : Listmonk::Types::Subscriber?
        fetch_subscriber(subscriber_id) { }
      end

      def create_subscriber(request : Listmonk::Types::SubscribeRequest, &block) : Listmonk::Types::Subscriber?
        post_request("/api/subscribers", request) do |response, errors|
          if response
            yield Listmonk::Types::Subscriber.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def create_subscriber(request : Listmonk::Types::SubscribeRequest) : Listmonk::Types::Subscriber?
        create_subscriber(request) { }
      end

      def blocklist_subscriber(subscriber_id : Int32, &block) : Listmonk::Types::GenericResponse?
        put_request("/api/subscribers/#{subscriber_id}/blocklist", nil) do |response, errors|
          if response
            yield Listmonk::Types::GenericResponse.new(success: response.as_bool), nil
          else
            yield nil, errors
          end
        end
      end

      def blocklist_subscriber(subscriber_id : Int32) : Listmonk::Types::GenericResponse?
        blocklist_subscriber(subscriber_id) { }
      end

      def delete_subscriber(subscriber_id : Int32, &block) : Listmonk::Types::GenericResponse?
        delete_request("/api/subscribers/#{subscriber_id}") do |response, errors|
          if response
            yield Listmonk::Types::GenericResponse.new(success: response.as_bool), nil
          else
            yield nil, errors
          end
        end
      end

      def delete_subscriber(subscriber_id : Int32) : Listmonk::Types::GenericResponse?
        delete_subscriber(subscriber_id) { }
      end
    end
  end
end
