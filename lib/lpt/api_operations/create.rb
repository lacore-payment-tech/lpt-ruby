# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, _opts = {})
        client = Lpt.client
        resource = new
        response = client.post(resource.resources_path, request.to_json)
        new(response.body)
      end
    end
  end
end
