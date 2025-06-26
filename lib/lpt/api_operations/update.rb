# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Update
      def update(id, request, _opts = {})
        client = Lpt.client
        resource = new(id: id)
        response = client.put(resource.resource_path, request.to_json)
        resource.load_from_response(response.body)
        resource
      end
    end
  end
end
