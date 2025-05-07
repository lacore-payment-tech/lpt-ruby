# frozen_string_literal: true

module LPT
  module Resource
    class InstrumentRequest < APIRequestModel
      attribute :profile
      attribute :instrument_id
      attribute :reference_id
      attribute :category
      attribute :type
      attribute :name
      attribute :contact
      attribute :address
      attribute :account
      attribute :expiration
      attribute :security_code
      attribute :authentication
      attribute :token
      attribute :entity
      attribute :external_token
      attribute :network_token

      
    end
  end
end
