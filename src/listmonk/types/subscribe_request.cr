require "json"

module Listmonk
  module Types
    struct SubscribeRequest
      include JSON::Serializable

      property name : String
      property email : String
      property status : String
      property lists : Array(Int32)?
      property attributes : JSON::Any?
      property preconfirm_subscriptions : Bool = true

      def initialize(@email : String,
                     @name : String,
                     @lists : Array(Int32)?,
                     @status : String = "enabled")
      end
    end
  end
end
