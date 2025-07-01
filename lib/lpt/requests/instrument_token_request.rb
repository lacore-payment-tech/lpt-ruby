# frozen_string_literal: true

module Lpt
  module Requests
    class InstrumentTokenRequest < ApiRequest
      attr_accessor :profile, :instrument_id, :reference_id, :name, :contact,
                    :address, :expiration, :token
    end
  end
end
