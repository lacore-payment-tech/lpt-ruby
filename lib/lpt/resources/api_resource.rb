# frozen_string_literal: true

module Lpt
  module Resources
    class ApiResource
      attr_accessor :id, :entity, :metadata, :created, :updated, :status,
                    :created_at, :updated_at

      def initialize(attributes = {})
        hydrate_attributes attributes
        assign_object_name
      end

      def object_name
        assert_object_name_implemented!
        @object_name
      end

      def base_path
        "/#{Lpt.api_version}"
      end

      def resources_path
        assert_concrete_class_used!
        # Namespaces are separated in object names with periods (.) and in URLs
        # with forward slashes (/), so replace the former with the latter.
        "#{base_path}/#{object_name.downcase.tr('.', '/')}s"
      end

      def resource_path
        assert_concrete_class_used!
        assert_valid_id_exists!
        "#{resources_path}/#{CGI.escape(id)}"
      end

      protected

      def assign_object_name; end

      def assert_concrete_class_used!
        return unless instance_of? ApiResource

        msg = <<~MSG
          APIResource is an abstract class. You should perform actions on its
          subclasses (Payment, Instrument, etc.)
        MSG
        raise NotImplementedError, msg
      end

      def assert_object_name_implemented!
        return unless @object_name.blank?

        msg = "Resources must implement #object_name"
        raise NotImplementedError, msg
      end

      def assert_valid_id_exists!
        return unless id.blank?

        msg = <<~MSG
          Could not determine which URL to request: #{self.class} instance has
          an invalid ID: #{id.inspect}
        MSG
        raise ArgumentError, msg
      end

      def load_from_response(response)
        return if response.blank?

        hydrate_attributes response
      end

      def hydrate_attributes(attributes)
        attributes.each_pair do |k, v|
          setter = :"#{k}="
          public_send(setter, v)
        rescue NoMethodError
          # noop
        end
      end
    end
  end
end
