# frozen_string_literal: true

module Lpt
  module Resources
    class Profile < ApiResource
      OBJECT_NAME = "profile"

      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create

      attr_accessor :id, :entity, :metadata, :profile_id, :reference_id, :name,
                    :contact, :address

      def initialize(id:)
        @id = id
      end

      def object_name
        OBJECT_NAME
      end

      def id_prefix
        "LID"
      end
    end
  end
end
