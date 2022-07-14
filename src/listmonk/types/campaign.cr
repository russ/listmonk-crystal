module Listmonk
  module Types
    struct Campaign
      include JSON::Serializable

      @[JSON::Field(key: "CampaignID")]
      property campaign_id : Int32?
      property id : Int32
      property uuid : String
      property name : String
      property type : String
      property tags : Array(String)
      property views : Int32
      property clicks : Int32
      property to_send : Int32
      property sent : Int32
      property subject : String
      property from_email : String
      property body : String
      property status : String
      property content_type : String
      property template_id : Int32
      property messenger : String
      property lists : Array(Listmonk::Types::List)
      property send_at : Time?
      property started_at : Time?
      property created_at : Time
      property updated_at : Time
    end
  end
end
