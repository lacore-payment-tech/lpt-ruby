# frozen_string_literal: true

module Lpt
  module Requests
    class EmptyRequest
      def to_json(*)
        nil
      end
    end
  end
end
