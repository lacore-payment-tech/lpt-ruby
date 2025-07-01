# frozen_string_literal: true

module Lpt
  module Requests
    class ApiRequest
      attr_accessor :entity

      def initialize(attributes = {})
        attributes.each_pair do |k, v|
          setter = :"#{k}="
          public_send(setter, v)
        end
        assign_default_entity
      end

      protected

      def assign_default_entity
        self.entity ||= Lpt.entity
      end
    end
  end
end
