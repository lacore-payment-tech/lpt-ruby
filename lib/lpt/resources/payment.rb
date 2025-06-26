# frozen_string_literal: true

module Lpt
  module Resources
    class Payment < ApiResource
      extend Lpt::ApiOperations::Retrieve
      extend Lpt::ApiOperations::Create
      extend Lpt::ApiOperations::Update

      attr_accessor :payment_id,
                    :reference_id,
                    :instrument,
                    :instrument_identifier,
                    :initiation,
                    :merchant,
                    :merchant_account,
                    :workflow,
                    :amount,
                    :currency,
                    :entity,
                    :order,
                    :invoice,
                    :session,
                    :profile,
                    :authorization,
                    :presentment,
                    :reversal,
                    :refunds,
                    :amount_refundable,
                    :result,
                    :url

      def id_prefix
        Lpt::PREFIX_PAYMENT
      end

      class << self
        def capture(id, request = nil, _opts = {})
          resource = new(id: id)
          unless resource.capture(request, _opts)
            return nil
          end

          resource
        end

        def reverse(id, request = nil, _opts = {})
          resource = new(id: id)
          unless resource.reverse(request, _opts)
            return nil
          end

          resource
        end

        def void(id, request = nil, _opts = {})
          resource = new(id: id)
          unless resource.void(request, _opts)
            return nil
          end

          resource
        end

        def refund(id, request = nil, _opts = {})
          resource = new(id: id)
          unless resource.refund(request, _opts)
            return nil
          end

          resource
        end
      end

      def capture(request = nil, _opts = {})
        client = Lpt.client
        path = "#{resource_path}/capture"
        request_str = request ? request.to_json : nil
        response = client.post(path, request_str)
        if response === nil or response.status > 201
          return false
        end

        return load_from_response(response.body)
      end

      def reverse(request = nil, _opts = {})
        client = Lpt.client
        path = "#{resource_path}/reverse"
        request_str = request ? request.to_json : nil
        response = client.post(path, request_str)
        if response === nil or response.status > 201
          return false
        end

        return load_from_response(response.body)
      end

      def void(request = nil, _opts = {})
        client = Lpt.client
        path = "#{resource_path}/void"
        request_str = request ? request.to_json : nil
        response = client.post(path, request_str)
        if response === nil or response.status > 201
          return false
        end

        return load_from_response(response.body)
      end

      def refund(request = nil, _opts = {})
        client = Lpt.client
        path = "#{resource_path}/refund"
        request_str = request ? request.to_json : nil
        response = client.post(path, request_str)
        if response === nil or response.status > 201
          return false
        end

        return load_from_response(response.body)
      end

      protected

      def assign_object_name
        @object_name = "payment"
      end
    end
  end
end
