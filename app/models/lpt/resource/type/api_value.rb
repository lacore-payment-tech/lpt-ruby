# frozen_string_literal: true

module LPT
  module Resource
    module Type
      class APIValue < ActiveModel::Type::Value
        def as_json(*)
          hash.as_json
        end

        def as_compact_json
          ArrayHelper.compact_recursive(as_json)
        end
      end
    end
  end
end
