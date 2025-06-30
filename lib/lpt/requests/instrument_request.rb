# frozen_string_literal: true

module Lpt
  module Requests
    class InstrumentRequest < ApiRequest
      attr_accessor :profile, :instrument_id, :reference_id, :category, :type,
                    :name, :contact, :address, :account, :expiration,
                    :security_code, :authentication, :token, :entity,
                    :external_token, :network_token
    end
  end
end
