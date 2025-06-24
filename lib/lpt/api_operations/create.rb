# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, opts = {})
        #if request.is_a? APIRequestModel
        #  params = request.as_compact_json
        #else
        #  params = request
        #end

        #Rails.logger.debug "POST #{url} -- \n#{params}"

        client = Lpt.client
        response = client.post(self.resource_url, params)
        if response.body
          resource = self.new(response.body)
          resource
        end
      end
    end
  end
end
