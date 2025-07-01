# frozen_string_literal: true

module Lpt
  module Requests
    class PaymentCaptureRequest < ApiRequest
      attr_accessor :invoice, :order, :payment_id, :reference_id, :amount,
                    :session
    end
  end
end
