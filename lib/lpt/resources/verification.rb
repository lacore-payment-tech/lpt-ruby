# frozen_string_literal: true

module Lpt
  module Resources
    class Verification < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      attr_accessor :verification_id, :reference_id, :subject, :profile,
                    :instrument, :merchant, :merchant_account, :category, :type,
                    :url, :result, :verified

      def id_prefix
        Lpt::PREFIX_VERIFICATION
      end

      protected

      def assign_object_name
        @object_name = "verification"
      end
    end
  end
end
