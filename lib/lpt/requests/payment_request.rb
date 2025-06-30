# frozen_string_literal: true

module Lpt
  module Requests
    class PaymentRequest < ApiRequest
      attr_accessor :merchant, :merchant_account, :instrument, :invoice, :order,
                    :payment_id, :reference_id, :amount, :currency, :session,
                    :initiation, :url, :recurring
    end
  end
end
