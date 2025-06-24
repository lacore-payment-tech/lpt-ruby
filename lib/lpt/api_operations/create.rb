# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, _opts = {})
        client = Lpt.client
        resource = new
        response = client.post(resource.resources_path, request.to_json)
        parse_response(response.body)
      end

      def parse_response(body)
        return unless body

        new(body)
      end
    end
  end
end
