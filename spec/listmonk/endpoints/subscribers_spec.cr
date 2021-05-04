require "../../spec_helper"

describe Listmonk::Endpoints::Subscribers do
  context "valid subscriber" do
    it "creates a subscriber" do
      Listmonk::Client.new.create_subscriber(valid_subscriber_request) do |subscriber, _|
        subscriber.not_nil!.name.should eq("The Subscriber")
      end
    end
  end

  context "invalid subscriber" do
    it "fails to create a subscriber" do
      Listmonk::Client.new.create_subscriber(invalid_subscriber_request) do |subscriber, errors|
        subscriber.should eq nil
        errors.should match /invalid e-mail/
      end
    end
  end

  it "fetches all subscribers based on a query" do
    Listmonk::Client.new.create_subscriber(valid_subscriber_request("Funky Joe")) do |subscriber, errors|
      Listmonk::Client.new.all_subscribers(page: 1, per_page: 1, query: "subscribers.name LIKE 'Funky%'") do |pages, errors|
        if pages
          if fetched_subscriber = pages.results.first
            subscriber.not_nil!.name.should eq fetched_subscriber.name
          end
        end
      end
    end
  end

  it "fetches a subscriber" do
    Listmonk::Client.new.create_subscriber(valid_subscriber_request) do |subscriber, _|
      Listmonk::Client.new.fetch_subscriber(subscriber.not_nil!.id) do |fetched_subscriber, _|
        subscriber.not_nil!.name.should eq fetched_subscriber.not_nil!.name
      end
    end
  end

  it "blocklists a subscriber" do
    Listmonk::Client.new.create_subscriber(valid_subscriber_request) do |subscriber, _|
      Listmonk::Client.new.blocklist_subscriber(subscriber.not_nil!.id) do |response, _|
        response.not_nil!.success?.should eq true
      end
    end
  end
end

def valid_subscriber_request(name : String = "The Subscriber")
  Listmonk::Types::SubscribeRequest.new(
    email: "subscriber+#{rand(1...1000)}@domain.com",
    name: name,
    lists: [1]
  )
end

def invalid_subscriber_request(name : String = "No Sir")
  Listmonk::Types::SubscribeRequest.new(
    email: "",
    name: name,
    lists: [1]
  )
end
