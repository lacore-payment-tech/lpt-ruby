# frozen_string_literal: true

module Lpt
  module Requests
    class PaymentRequest < ApiRequest
      attr_accessor :merchant, :merchant_account, :instrument, :invoice, :order,
                    :payment_id, :reference_id, :amount, :currency, :session,
                    :initiation, :url, :recurring, :workflow

      def initialize(*)
        super
        assign_merchant
      end

      protected

      def assign_merchant
        self.merchant ||= Lpt.merchant
      end
    end
  end
end
