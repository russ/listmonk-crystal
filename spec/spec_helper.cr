Listmonk.configure do |settings|
  settings.host = "localhost"
  settings.port = "9000"
  settings.username = "listmonk"
  settings.password = "listmonk"
end

require "spec"
require "../src/listmonk"
