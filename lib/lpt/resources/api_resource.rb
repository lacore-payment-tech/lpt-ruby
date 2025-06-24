# frozen_string_literal: true

module Lpt
  module Resources
    class ApiResource
      attr_accessor :id, :created, :updated, :status, :created_at, :updated_at

      def initialize(attributes = {})
        attributes.each_pair do |k, v|
          setter = :"#{k}="
          public_send(setter, v)
        end
      end

      def base_path
        # TODO: move into config
        "/v2"
      end

      def resources_path
        assert_concrete_class_used!
        # Namespaces are separated in object names with periods (.) and in URLs
        # with forward slashes (/), so replace the former with the latter.
        "#{base_path}/#{object_name.downcase.tr('.', '/')}s"
      end

      def resource_path
        assert_valid_id_exists!
        "#{base_resource_path}/#{CGI.escape(id)}"
      end

      protected

      def assert_concrete_class_used!
        return unless self == ApiResource

        msg = <<~MSG
          APIResource is an abstract class. You should perform actions on its
          subclasses (Payment, Instrument, etc.)
        MSG
        raise NotImplementedError, msg
      end

      def assert_valid_id_exists!
        return if id

        msg = <<~MSG
          Could not determine which URL to request: #{self.class} instance has
          an invalid ID: #{id.inspect}
        MSG
        raise InvalidRequestError, msg
      end
    end
  end
end
