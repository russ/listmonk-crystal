require "json"
require "uuid"
require "uuid/json"
require "habitat"
require "./listmonk/*"
require "./listmonk/types/*"

module Listmonk
  Habitat.create do
    setting host : String
    setting port : String?
    setting username : String
    setting password : String
  end
end

# Habitat.raise_if_missing_settings!
