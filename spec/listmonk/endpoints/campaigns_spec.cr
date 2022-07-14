require "../../spec_helper"

describe Listmonk::Endpoints::Campaigns do
  context "with blocks" do
    it "fetches all campaigns" do
      Listmonk::Client.new.all_campaigns(page: 1, per_page: 1) do |pages, _|
        if pages
          (pages.results.size > 0).should eq true
        end
      end
    end

    it "fetches a campaign" do
      Listmonk::Client.new.create_campaign(valid_campaign_request) do |campaign, _|
        Listmonk::Client.new.fetch_campaign(campaign.not_nil!.id) do |fetched_campaign, _|
          campaign.not_nil!.name.should eq fetched_campaign.not_nil!.name
        end
      end
    end
  end
end

def valid_campaign_request(name : String = "The Campaign")
  Listmonk::Types::CampaignRequest.new(
    name: name,
    subject: name,
    lists: [1],
    from_email: "Billy Bob <billy@bob.com>",
    type: "regular",
    content_type: "html",
    messenger: "email",
    tags: ["test"],
    template_id: 1,
    body: "FOOBAR",
  )
end
