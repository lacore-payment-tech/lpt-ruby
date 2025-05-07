# frozen_string_literal: true

module LPT
  module Resource
    class Payment < APIResource
      include LPT::Resource::Retrieve
      include LPT::Resource::Create

      OBJECT_NAME = "payment"
      def self.object_name
        "payment"
      end

      def self.id_prefix
        "LPY"
      end

      attribute :metadata
      attribute :payment_id, :string
      attribute :reference_id, :string
      attribute :instrument, :string
      attribute :instrument_identifier
      attribute :initiation
      attribute :merchant
      attribute :merchant_account
      attribute :workflow
      attribute :amount, :integer
      attribute :currency

      attribute :entity, :string
      attribute :order
      attribute :invoice
      attribute :session
      attribute :profile
      attribute :authorization
      attribute :presentment
      attribute :reversal

      attribute :amount_refundable

      attribute :result
      attribute :url

      def capture(params = nil)
        url = "#{resource_url}/capture"
        self.attributes = post(url, params)

        self
      end

      def refund(params = nil)
        url = "#{resource_url}/refund"
        self.attributes = post(url, params)

        self
      end

      def reverse(params = nil)
        url = "#{resource_url}/reverse"
        self.attributes = post(url, params)

        self
      end

      protected
      def post(url, params)
        client = LPT.client
        response = client.post(url, params)
        unless response.body
          return nil
        end

        response.body
      end
    end
  end
end
