# frozen_string_literal: true

module Lpt
  module Resources
    class Instrument < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      attr_accessor :profile,
                    :metadata,
                    :instrument_id,
                    :reference_id,
                    :category,
                    :type,
                    :account_type,
                    :name,
                    :contact,
                    :address,
                    :identifier,
                    :brand,
                    :network,
                    :issuer_identifier,
                    :issuer,
                    :expiration,
                    :fingerprint

      def id_prefix
        Lpt::PREFIX_INSTRUMENT
      end

      def self.associate_token(token_id, profile_id, _opts = {})
        request = Lpt::Requests::InstrumentTokenRequest.new
        request.entity = Lpt.entity
        request.token = token_id
        request.profile = profile_id

        client = Lpt.client
        response = client.post(self.resources_path, request.to_json)
        if response.status > 201
          return false
        end

        new(response.body)
      end

      protected

      def assign_object_name
        @object_name = "instrument"
      end
    end
  end
end
