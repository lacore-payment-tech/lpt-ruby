# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Payment do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Payment.new

      expect(result.object_name).to be_present
    end
  end

  describe "#capture" do
    before { configure_client }

    it "uses the path for capturing a payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      capture_path = "/v2/payments/#{Lpt::PREFIX_PAYMENT}/capture"
      client = Lpt.client
      allow(client).to receive(:post).and_call_original
      stub_payment_capture id: Lpt::PREFIX_PAYMENT
      stub_lpt_client client

      resource.capture

      expect(client).to have_received(:post).once.with(capture_path, anything)
    end

    it "returns the payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      stub_payment_capture id: Lpt::PREFIX_PAYMENT

      result = resource.capture

      expect(result.reference_id).to be_present
    end
  end

  describe "#refund" do
    before { configure_client }

    it "uses the path for refunding a payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      refund_path = "/v2/payments/#{Lpt::PREFIX_PAYMENT}/refund"
      client = Lpt.client
      allow(client).to receive(:post).and_call_original
      stub_payment_refund id: Lpt::PREFIX_PAYMENT
      stub_lpt_client client

      resource.refund

      expect(client).to have_received(:post).once.with(refund_path, anything)
    end

    it "returns the payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      stub_payment_refund id: Lpt::PREFIX_PAYMENT

      result = resource.refund

      expect(result.reference_id).to be_present
    end
  end

  describe "#reverse" do
    before { configure_client }

    it "uses the path for reversing a payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      reverse_path = "/v2/payments/#{Lpt::PREFIX_PAYMENT}/reverse"
      client = Lpt.client
      allow(client).to receive(:post).and_call_original
      stub_payment_reverse id: Lpt::PREFIX_PAYMENT
      stub_lpt_client client

      resource.reverse

      expect(client).to have_received(:post).once.with(reverse_path, anything)
    end

    it "returns the payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      stub_payment_reverse id: Lpt::PREFIX_PAYMENT

      result = resource.reverse

      expect(result.reference_id).to be_present
    end
  end

  describe "#void" do
    before { configure_client }

    it "uses the path for voiding a payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      void_path = "/v2/payments/#{Lpt::PREFIX_PAYMENT}/void"
      client = Lpt.client
      allow(client).to receive(:post).and_call_original
      stub_payment_void id: Lpt::PREFIX_PAYMENT
      stub_lpt_client client

      resource.void

      expect(client).to have_received(:post).once.with(void_path, anything)
    end

    it "returns the payment" do
      resource = Lpt::Resources::Payment.new(id: Lpt::PREFIX_PAYMENT)
      stub_payment_void id: Lpt::PREFIX_PAYMENT

      result = resource.void

      expect(result.reference_id).to be_present
    end
  end

  describe ".auth" do
    before { configure_client }

    it "assigns the auth capture workflow to the request" do
      request = Lpt::Requests::PaymentRequest.new
      allow(request).to receive(:as_auth_capture).and_call_original
      stub_payment_create

      Lpt::Resources::Payment.auth(request)

      expect(request).to have_received(:as_auth_capture).once
    end

    it "returns a payment" do
      request = Lpt::Requests::PaymentRequest.new(instrument: "LPIXXXXXXXX")
      stub_payment_create

      result = Lpt::Resources::Payment.auth(request)

      expect(result.id).to start_with(Lpt::PREFIX_PAYMENT)
    end
  end

  describe ".sale" do
    before { configure_client }

    it "assigns the sale workflow to the request" do
      request = Lpt::Requests::PaymentRequest.new
      allow(request).to receive(:as_sale).and_call_original
      stub_payment_create

      Lpt::Resources::Payment.sale(request)

      expect(request).to have_received(:as_sale).once
    end

    it "returns a payment" do
      request = Lpt::Requests::PaymentRequest.new(instrument: "LPIXXXXXXX")
      stub_payment_create

      result = Lpt::Resources::Payment.sale(request)

      expect(result.id).to start_with(Lpt::PREFIX_PAYMENT)
    end
  end

  describe ".retrieve" do
    before { configure_client }

    it "returns the existing payment" do
      payment_id = "#{Lpt::PREFIX_PAYMENT}123123123"
      stub_payment_retrieve id: payment_id

      result = Lpt::Resources::Payment.retrieve(payment_id)

      expect(result.id).to eq(payment_id)
    end
  end

  describe ".create" do
    before { configure_client }

    it "returns the created payment" do
      payment_request = Lpt::Requests::PaymentRequest.new
      stub_payment_create

      result = Lpt::Resources::Payment.create(payment_request)

      expect(result.id).to be_present
    end
  end
end
