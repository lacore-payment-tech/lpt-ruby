# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, opts = {})
        client = Lpt.client
        resource = new
        response = client.post(resource.base_resource_path, request.to_json)
        if response.body
          new(response.body)
        end
      end
    end
  end
end
