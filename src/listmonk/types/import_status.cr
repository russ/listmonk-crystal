module Listmonk
  module Types
    struct ImportStatus
      include JSON::Serializable

      property name : String
      property total : Int32
      property imported : Int32
      property status : String
    end
  end
end
