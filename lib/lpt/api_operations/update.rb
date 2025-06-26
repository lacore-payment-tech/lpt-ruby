# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Update
      def update(request, _opts = {})
        client = Lpt.client
        resource = new
        response = client.put(resource.resources_path, request.to_json)
        resource.load_from_response(response.body)

        resource
      end
    end
  end
end
