module Listmonk
  module Types
    struct ListSubscription
      include JSON::Serializable

      property id : Int32
      property uuid : UUID
      property name : String
      property type : String
      property optin : String
      property tags : Array(String)
      property subscription_status : String
      property created_at : Time
      property updated_at : Time
    end
  end
end
