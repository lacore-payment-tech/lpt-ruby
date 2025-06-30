# frozen_string_literal: true

module Lpt
  module Resources
    class Instrument < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      attr_accessor :profile, :metadata, :instrument_id, :reference_id,
                    :category, :type, :account_type, :name, :contact,
                    :address, :identifier, :brand, :network, :issuer_identifier,
                    :issuer, :expiration, :fingerprint, :token

      def id_prefix
        Lpt::PREFIX_INSTRUMENT
      end

      protected

      def assign_object_name
        @object_name = "instrument"
      end
    end
  end
end
