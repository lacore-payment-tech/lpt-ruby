# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Requests::PaymentRequest do
  describe "#initialize" do
    it "assigns the merchant" do
      Lpt.merchant = "LMR123123123"
      result = Lpt::Requests::PaymentRequest.new

      expect(result.merchant).to eq("LMR123123123")
    end
  end

  describe "#as_auth_capture" do
    it "sets the workflow to auth/capture" do
      auth_capture = Lpt::Requests::PaymentRequest::WORKFLOW_AUTH_CAPTURE
      request = Lpt::Requests::PaymentRequest.new

      request.as_auth_capture

      expect(request.workflow).to eq(auth_capture)
    end

    it "supports method chaining" do
      request = Lpt::Requests::PaymentRequest.new

      result = request.as_auth_capture

      expect(result).to eq(request)
    end
  end

  describe "#as_sale" do
    it "sets the workflow to sale" do
      sale = Lpt::Requests::PaymentRequest::WORKFLOW_SALE
      request = Lpt::Requests::PaymentRequest.new

      request.as_sale

      expect(request.workflow).to eq(sale)
    end

    it "supports method chaining" do
      request = Lpt::Requests::PaymentRequest.new

      result = request.as_sale

      expect(result).to eq(request)
    end
  end

  describe "#as_recurring_payment" do
    it "sets initiation by the merchant" do
      initiated_by_merchant = Lpt::Requests::PaymentRequest::INITIATION_MERCHANT
      request = Lpt::Requests::PaymentRequest.new

      request.as_recurring_payment

      expect(request.initiation).to eq(initiated_by_merchant)
    end

    it "supports method chaining" do
      request = Lpt::Requests::PaymentRequest.new

      result = request.as_recurring_payment

      expect(result).to eq(request)
    end
  end
end
