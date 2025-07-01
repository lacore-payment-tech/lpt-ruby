# frozen_string_literal: true

module Lpt
  module Resources
    class Profile < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      attr_accessor :profile_id, :reference_id, :name, :contact, :address

      def id_prefix
        Lpt::PREFIX_PROFILE
      end

      def associate_instrument(instrument_token_request)
        assert_valid_id_exists!
        assert_token_exists! instrument_token_request
        instrument_token_request.profile = id
        Lpt::Resources::Instrument.create(instrument_token_request)
      rescue ArgumentError
        false
      end

      protected

      def assign_object_name
        @object_name = "profile"
      end

      def assert_valid_id_exists!
        return if id.present?

        raise ArgumentError, "A profile ID is required"
      end

      def assert_token_exists!(request)
        return if request.token.present?

        raise ArgumentError, "An instrument token is required"
      end
    end
  end
end
