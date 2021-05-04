module Listmonk
  module Types
    struct GenericResponse
      property success : Bool

      def initialize(@success : Bool)
      end

      def success?
        @success == true
      end
    end
  end
end
