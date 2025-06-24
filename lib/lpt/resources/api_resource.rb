# frozen_string_literal: true

module Lpt
  module Resources
    class ApiResource
      attr_accessor :id, :created, :updated, :status

      def base_path
        # TODO: move into config
        "/v2"
      end

      def base_resource_path
        #if self == APIResource
        #  raise ::NotImplementedError,
        #        "APIResource is an abstract class. You should perform actions on its subclasses (Payment, Instrument, etc.)"
        #end
        # Namespaces are separated in object names with periods (.) and in URLs
        # with forward slashes (/), so replace the former with the latter.
        "#{base_path}/#{object_name.downcase.tr('.', '/')}s"
      end

      def resource_path
        #unless id
        #  raise ::InvalidRequestError.new(
        #    "Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}",
        #    "id"
        #  )
        #end
        "#{base_resource_path}/#{CGI.escape(id)}"
      end
    end
  end
end
