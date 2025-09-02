# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Retrieve
      def retrieve(id, _opts = {})
        client = Lpt.client
        resource = new(id: id)
        response = client.get(resource.resource_path)
        new(response.body)
      rescue Faraday::Error => e
        raise Lpt::ResourceRetrievalFailure, e.message
      end
    end
  end
end
