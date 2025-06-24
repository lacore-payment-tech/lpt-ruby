# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, opts = {})
        client = Lpt.client
        response = client.post(self.resource_path, request.to_json)
        if response.body
          puts "-- RESPONSE"
          puts response.body.inspect
          resource = self.new(response.body)
          resource
        end
      end
    end
  end
end
