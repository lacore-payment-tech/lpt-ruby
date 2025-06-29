# frozen_string_literal: true

module Lpt
  module Resources
    class Profile < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create

      attr_accessor :entity, :metadata, :profile_id, :reference_id, :name,
                    :contact, :address

      def id_prefix
        Lpt::PREFIX_PROFILE
      end

      protected

      def assign_object_name
        @object_name = "profile"
      end
    end
  end
end
