# frozen_string_literal: true

module LPT
  module Resource
    class PaymentRequest < APIRequestModel
      attribute :merchant
      attribute :merchant_account
      attribute :instrument
      attribute :invoice
      attribute :order
      attribute :payment_id
      attribute :reference_id
      attribute :amount
      attribute :currency
      attribute :session
      attribute :initiation
      attribute :url
      attribute :recurring

    end
  end
end
