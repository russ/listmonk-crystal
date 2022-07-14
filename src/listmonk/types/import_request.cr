require "json"

module Listmonk
  module Types
    struct ImportRequest
      include JSON::Serializable

      @[JSON::Field(key: "mode")]
      property mode : String

      @[JSON::Field(key: "lists")]
      property lists : Array(Int32)

      @[JSON::Field(ignore: true)]
      property file : String

      @[JSON::Field(key: "delim")]
      property delim : String = ","

      @[JSON::Field(key: "overwrite")]
      property overwrite : Bool = true

      def initialize(@mode : String,
                     @lists : Array(Int32)?,
                     @file : String,
                     @delim : String = ",",
                     @overwrite : Bool = true)
      end
    end
  end
end
