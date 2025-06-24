# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Retrieve
      def retrieve(id, opts = {})
        client = Lpt.client
        resource = new(id: id)
        response = client.get(resource.resource_path)
        if response.body
          new(response.body)
        end
      end
    end
  end
end
