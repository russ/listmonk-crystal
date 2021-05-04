require "./list_subscription"

module Listmonk
  module Types
    struct Subscriber
      include JSON::Serializable

      property id : Int32
      property uuid : UUID
      property name : String
      property email : String
      property status : String
      property lists : Array(Listmonk::Types::ListSubscription)
      property attributes : JSON::Any?
      property created_at : Time
      property updated_at : Time

      def initialize(@id : Int32,
                     @uuid : UUID,
                     @email : String,
                     @name : String,
                     @lists : Array(Int32)?,
                     @status : String = "enabled",
                     @created_at : Time = Time.utc,
                     @updated_at : Time = Time.utc)
      end
    end
  end
end
