module Listmonk
  module Types
    struct List
      include JSON::Serializable

      property id : Int32
      property uuid : UUID
      property name : String
      property type : String
      property optin : String
      property tags : Array(String)
      property subscriber_count : Int32
      property created_at : Time
      property updated_at : Time
    end
  end
end
