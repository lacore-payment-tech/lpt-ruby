# frozen_string_literal: true

module Lpt
  module Requests
    class ApiRequest
      def initialize(attributes = {})
        attributes.each_pair do |k, v|
          setter = :"#{k}="
          public_send(setter, v)
        end
      end
    end
  end
end
