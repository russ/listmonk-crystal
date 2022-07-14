module Listmonk
  module Endpoints
    module Campaigns
      def all_campaigns(page : Int32 = 1, per_page : Int32 = 20, &block) : Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::Campaign))?
        params = {
          "page"     => page.to_s,
          "per_page" => per_page.to_s,
        }

        get_request("/api/campaigns", query: URI::Params.encode(params)) do |response, errors|
          if response.nil?
            yield nil, errors
          else
            yield Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::Campaign)).from_json(response.to_json), nil
          end
        end
      end

      def all_campaigns(page : Int32 = 1, per_page : Int32 = 20) : Listmonk::Types::PaginatedResponse(Array(Listmonk::Types::Campaign))?
        all_campaigns { }
      end

      def fetch_campaign(campaign_id : Int32) : Listmonk::Types::Campaign?
        get_request("/api/campaigns/#{campaign_id}") do |response, errors|
          if response
            yield Listmonk::Types::Campaign.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def fetch_campaign(campaign_id : Int32) : Listmonk::Types::Campaign?
        fetch_campaign(campaign_id) { }
      end

      def create_campaign(request : Listmonk::Types::CampaignRequest, &block) : Listmonk::Types::Campaign?
        post_request("/api/campaigns", request) do |response, errors|
          if response
            yield Listmonk::Types::Campaign.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def create_campaign(request : Listmonk::Types::CampaignRequest) : Listmonk::Types::Campaign?
        create_campaign(request) { }
      end
    end
  end
end
