# "{\"data\":{\"name\":\"file\",\"total\":0,\"imported\":0,\"status\":\"importing\"}}\n",

require "json"

module Listmonk
  module Types
    struct ImportRequestResponse
      include JSON::Serializable

      @[JSON::Field(key: "name")]
      property name : String

      @[JSON::Field(key: "total")]
      property total : Int32

      @[JSON::Field(key: "imported")]
      property imported : Int32

      @[JSON::Field(key: "status")]
      property status : String

      def initialize(@name : String,
                     @total : Int32,
                     @imported : Int32,
                     @status : String)
      end
    end
  end
end
