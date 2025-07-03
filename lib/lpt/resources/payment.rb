# frozen_string_literal: true

module Lpt
  module Resources
    class Payment < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      WORKFLOW_SALE = "SALE"
      WORKFLOW_AUTH_CAPTURE = "AUTH_CAPTURE"

      attr_accessor :payment_id, :reference_id, :instrument,
                    :instrument_identifier, :initiation, :merchant,
                    :merchant_account, :workflow, :amount, :currency, :order,
                    :invoice, :session, :profile, :authorization, :presentment,
                    :reversal, :refunds, :amount_refundable, :result, :url

      def id_prefix
        Lpt::PREFIX_PAYMENT
      end

      def capture(request = Lpt::Requests::EmptyRequest.new)
        path = "#{resource_path}/capture"
        Lpt::Resources::Payment.create(request, path: path)
      end

      def refund(request = Lpt::Requests::EmptyRequest.new)
        path = "#{resource_path}/refund"
        Lpt::Resources::Payment.create(request, path: path)
      end

      def reverse(request = Lpt::Requests::EmptyRequest.new)
        path = "#{resource_path}/reverse"
        Lpt::Resources::Payment.create(request, path: path)
      end

      def void(request = Lpt::Requests::EmptyRequest.new)
        path = "#{resource_path}/void"
        Lpt::Resources::Payment.create(request, path: path)
      end

      protected

      def assign_object_name
        @object_name = "payment"
      end
    end
  end
end
