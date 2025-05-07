# frozen_string_literal: true

module LPT
  module Resource
    ActiveModel::Type.register(:address, LPT::Resource::Type::Address)
    ActiveModel::Type.register(:name, LPT::Resource::Type::Name)
    ActiveModel::Type.register(:contact, LPT::Resource::Type::Contact)

    class APIResource
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON
      include ActiveModel::Conversion

      attribute :id, :string
      attribute :created, :datetime
      attribute :updated, :datetime
      attribute :status, :string
      attribute :created_at, :integer
      attribute :updated_at, :integer

      class << self
        def base_url
          "/v2"
        end

        def resource_url
          if self == APIResource
            raise ::NotImplementedError,
                  "APIResource is an abstract class. You should perform actions on its subclasses (Payment, Instrument, etc.)"
          end
          # Namespaces are separated in object names with periods (.) and in URLs
          # with forward slashes (/), so replace the former with the latter.
          "/v2/#{object_name.downcase.tr('.', '/')}s"
        end
      end

      def resource_url
        unless id
          raise ::InvalidRequestError.new(
            "Could not determine which URL to request: #{self.class} instance has invalid ID: #{id.inspect}",
            "id"
          )
        end
        "#{self.class.resource_url}/#{CGI.escape(id)}"
      end

      def assign_attributes(new_attributes)
        super
      end

      def as_compact_json
        ArrayHelper.compact_recursive(as_json)
      end
    end
  end
end
