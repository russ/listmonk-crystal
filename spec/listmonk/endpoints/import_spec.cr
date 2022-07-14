require "../../spec_helper"
require "csv"

describe Listmonk::Endpoints::Import do
  context "with blocks" do
    it "gets the import status" do
      Listmonk::Client.new.delete_import

      Listmonk::Client.new.fetch_import_status do |result, _|
        if success = result
          success.status.should eq "none"
        end
      end

      Listmonk::Client.new.delete_import
    end

    it "imports a csv list of subscribers" do
      Listmonk::Client.new.delete_import

      Listmonk::Client.new.import_subscribers(valid_import_request) do |result, _|
        if success = result
          success.total.should eq 1
        end
      end

      Listmonk::Client.new.fetch_import_status do |result, _|
        if success = result
          %w(importing finished).includes?(success.status).should eq true
        end
      end

      Listmonk::Client.new.delete_import
    end

    it "throws an error when an import is still running" do
      Listmonk::Client.new.delete_import

      Listmonk::Client.new.import_subscribers(valid_import_request) do |result, _|
        if success = result
          success.total.should eq 1
        end
      end

      expect_raises(Listmonk::Errors::ImportAlreadyRunning) do
        Listmonk::Client.new.import_subscribers(valid_import_request) do |_, _|
        end
      end

      Listmonk::Client.new.delete_import
    end
  end
end

def valid_import_request
  file = CSV.build do |csv|
    csv.row("email", "name", "attributes")
    csv.row("billy@bob.com", "Billy Bob", {"likesTurtles" => true}.to_json)
  end

  Listmonk::Types::ImportRequest.new(
    mode: "subscribe",
    lists: [1],
    file: file,
  )
end
