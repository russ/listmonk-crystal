require "json"

module Listmonk
  module Types
    struct CampaignRequest
      include JSON::Serializable

      property name : String
      property subject : String
      property lists : Array(Int32)
      property from_email : String?
      property type : String
      property content_type : String
      property body : String
      property alt_body : String?
      property send_at : Time?
      property messenger : String?
      property template_id : Int32?
      property tags : Array(String)?

      def initialize(
        @name : String,
        @subject : String,
        @lists : Array(Int32),
        @type : String,
        @content_type : String,
        @body : String,
        @from_email : String? = nil,
        @alt_body : String? = nil,
        @send_at : Time? = nil,
        @messenger : String? = nil,
        @template_id : Int32? = nil,
        @tags : Array(String)? = nil
      )
      end
    end
  end
end
