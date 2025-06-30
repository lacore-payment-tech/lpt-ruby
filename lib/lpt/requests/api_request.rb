# frozen_string_literal: true

module Lpt
  module Requests
    class ApiRequest
      attr_writer :entity

      def initialize(attributes = {})
        attributes.each_pair do |k, v|
          setter = :"#{k}="
          public_send(setter, v)
        end
      end

      def entity
        @entity || Lpt.entity
      end
    end
  end
end
