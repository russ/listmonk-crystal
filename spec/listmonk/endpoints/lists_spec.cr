require "../../spec_helper"

describe Listmonk::Endpoints::Lists do
  context "with blocks" do
    it "fetches all lists" do
      Listmonk::Client.new.all_lists(page: 1, per_page: 1) do |pages, _|
        if pages
          if list = pages.results.first
            list.id.should eq 2
            ["Default list", "Opt-in list"].includes?(list.name).should eq true
          end
        end
      end
    end
  end

  context "valid list" do
    it "creates a list" do
      name = "The List"

      Listmonk::Client.new.create_list(valid_list_request(name)) do |list, _|
        list.not_nil!.name.should eq(name)
      end
    end
  end

  context "valid list" do
    it "updates a list" do
      list = nil

      Listmonk::Client.new.create_list(valid_list_request("The Other List")) do |l, _|
        l.not_nil!.name.should eq("The Other List")
        list = l
      end

      if list
        Listmonk::Client.new.update_list(list.not_nil!.id, valid_list_request("Updated List Name")) do |l, e|
          l.not_nil!.name.should eq("Updated List Name")
        end
      end
    end
  end

  context "valid list" do
    it "deletes a list" do
      list = nil

      Listmonk::Client.new.create_list(valid_list_request("The One to be Deleted")) do |l, _|
        l.not_nil!.name.should eq("The One to be Deleted")
        list = l
      end

      if list
        Listmonk::Client.new.delete_list(list.not_nil!.id) do |response, _|
          response.not_nil!.success?.should eq true
        end
      end
    end
  end
end

def valid_list_request(name : String, type : String = "private", optin : String = "single")
  Listmonk::Types::ListRequest.new(
    name: name,
    type: type,
    optin: optin,
  )
end
