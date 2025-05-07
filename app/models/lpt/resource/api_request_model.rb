# frozen_string_literal: true

module LPT
  module Resource
    class APIRequestModel
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON
      include ActiveModel::Conversion

      attribute :metadata

      def as_compact_json
        ArrayHelper.compact_recursive(as_json)
      end
    end
  end
end
