# frozen_string_literal: true

module Lpt
  module Requests
    class PaymentRequest < ApiRequest
      INITIATION_CUSTOMER = "CUSTOMER"
      INITIATION_MERCHANT = "MERCHANT"

      WORKFLOW_SALE = "SALE"
      WORKFLOW_AUTH_CAPTURE = "AUTH_CAPTURE"

      attr_accessor :merchant, :merchant_account, :instrument, :invoice, :order,
                    :payment_id, :reference_id, :amount, :currency, :session,
                    :initiation, :url, :recurring, :workflow

      def initialize(*)
        super
        assign_merchant
      end

      def as_auth_capture
        self.workflow = WORKFLOW_AUTH_CAPTURE
        self
      end

      def as_sale
        self.workflow = WORKFLOW_SALE
        self
      end

      def as_recurring_payment
        self.initiation = INITIATION_MERCHANT
        self
      end

      protected

      def assign_merchant
        self.merchant ||= Lpt.merchant
      end
    end
  end
end
