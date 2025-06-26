# frozen_string_literal: true

module Lpt
  module Requests
    class PaymentRefundRequest < ApiRequest
      attr_accessor :reference_id,
                    :amount,
                    :session
    end
  end
end
