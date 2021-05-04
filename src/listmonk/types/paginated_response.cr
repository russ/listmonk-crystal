module Listmonk
  module Types
    struct PaginatedResponse(T)
      include JSON::Serializable

      property results : T
      property total : Int32
      property per_page : Int32
      property page : Int32
    end
  end
end
