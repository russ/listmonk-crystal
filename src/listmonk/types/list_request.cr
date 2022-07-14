require "json"

module Listmonk
  module Types
    struct ListRequest
      include JSON::Serializable

      property name : String
      property type : String
      property optin : String

      def initialize(@name : String,
                     @type : String,
                     @optin : String)
      end
    end
  end
end
