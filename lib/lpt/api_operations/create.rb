# frozen_string_literal: true

module Lpt
  module ApiOperations
    module Create
      def create(request, path: nil)
        client = Lpt.client
        resource = new
        path ||= resource.resources_path
        response = client.post(path, request.to_json)
        handle_response resource, response
        resource
      rescue Faraday::Error => e
        raise Lpt::ResourceCreationFailure, e.message
      end

      protected

      def post_request_failed?(response)
        response.blank? || response.status > 201
      end

      def handle_response(resource, response)
        return false if post_request_failed? response

        resource.load_from_response(response.body)
      end
    end
  end
end
