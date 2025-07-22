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

      def expiration_month
        expiration.with_indifferent_access["month"]
      end

      def expiration_year
        expiration.with_indifferent_access["year"]
      end

      def auth(payment_request)
        assert_valid_id_exists!
        payment_request.instrument = id
        Lpt::Resources::Payment.auth(payment_request)
      rescue ArgumentError
        false
      end

      def charge(payment_request)
        assert_valid_id_exists!
        payment_request.instrument = id
        Lpt::Resources::Payment.sale(payment_request)
      rescue ArgumentError
        false
      end

      def self.tokenize(instrument_token_request)
        path = token_path
        Lpt::Resources::Instrument.create(instrument_token_request, path: path)
      end

      def self.token_path(entity: nil)
        resource = new
        [resource.resources_path, "token", entity].compact.join("/")
      end

      protected

      def assign_object_name
        @object_name = "instrument"
      end

      def assert_valid_id_exists!
        return if id.present?

        raise ArgumentError, "An instrument ID is required"
      end
    end
  end
end
