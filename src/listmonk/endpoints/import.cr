require "compress/zip"

module Listmonk
  module Endpoints
    module Import
      def fetch_import_status(&block) #  : Listmonk::Types::ImportStatus?
        get_request("/api/import/subscribers") do |response, errors|
          if response
            yield Listmonk::Types::ImportStatus.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def fetch_import_status : Listmonk::Types::ImportStatus?
        fetch_import_status { }
      end

      def import_subscribers(request : Listmonk::Types::ImportRequest, &block) : Listmonk::Types::ImportRequestResponse?
        IO.pipe do |reader, writer|
          channel = Channel(String).new(1)

          spawn do
            HTTP::FormData.build(writer) do |formdata|
              channel.send(formdata.content_type)

              formdata.field("params", request.to_json)

              io = IO::Memory.new
              Compress::Zip::Writer.open(io) do |zip|
                zip.add "file.csv", &.print(request.file)
              end
              io.rewind

              metadata = HTTP::FormData::FileMetadata.new(filename: "file")
              headers = HTTP::Headers{"Content-Type" => "application/zip"}
              formdata.file("file", io, metadata, headers)
            end

            writer.close
          end

          headers = HTTP::Headers{"Content-Type" => channel.receive}
          response = @http_client.post("/api/import/subscribers", body: reader, headers: headers)
          json_response = JSON.parse(response.body).as_h

          if data = json_response["data"]?
            Listmonk::Types::ImportRequestResponse.from_json(data.to_json)
          elsif error = json_response["message"]?
            raise Listmonk::Errors::ImportAlreadyRunning.new(error.as_s)
          end
        end
      end

      def delete_import(&block) : Listmonk::Types::ImportRequestResponse?
        delete_request("/api/import/subscribers") do |response, errors|
          if response
            yield Listmonk::Types::ImportRequestResponse.from_json(response.to_json), nil
          else
            yield nil, errors
          end
        end
      end

      def delete_import : Listmonk::Types::ImportRequestResponse?
        delete_import { }
      end
    end
  end
end
