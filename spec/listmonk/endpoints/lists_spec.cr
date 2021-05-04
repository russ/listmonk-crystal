require "../../spec_helper"

describe Listmonk::Endpoints::Lists do
  context "with blocks" do
    it "fetches all lists" do
      Listmonk::Client.new.all_lists(page: 1, per_page: 1) do |pages, _|
        if pages
          if list = pages.results.first
            list.id.should eq 1
            list.name.should eq "Default list"
          end
        end
      end
    end
  end
end
