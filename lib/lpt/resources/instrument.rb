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

      def auth(payment_request)
        create_payment(payment_request,
                       workflow: Lpt::Resources::Payment::WORKFLOW_AUTH_CAPTURE)
      end

      def charge(payment_request)
        create_payment(payment_request,
                       workflow: Lpt::Resources::Payment::WORKFLOW_SALE)
      end

      protected

      def assign_object_name
        @object_name = "instrument"
      end

      def assert_valid_id_exists!
        return if id.present?

        raise ArgumentError, "An instrument ID is required"
      end

      def create_payment(payment_request, workflow:)
        assert_valid_id_exists!
        payment_request.workflow = workflow
        payment_request.instrument = id
        Lpt::Resources::Payment.create(payment_request)
      rescue ArgumentError
        false
      end
    end
  end
end
