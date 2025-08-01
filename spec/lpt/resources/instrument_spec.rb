# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Instrument do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Instrument.new

      expect(result.object_name).to be_present
    end
  end

  describe "#expiration_month" do
    it "returns the month from the expiration hash" do
      instrument = Lpt::Resources::Instrument.new(
        expiration: { month: "04", year: "2044" }
      )

      result = instrument.expiration_month

      expect(result).to eq("04")
    end

    context "when the expiration is not set" do
      it "does not raise an error" do
        instrument = Lpt::Resources::Instrument.new(expiration: nil)

        expect {
          instrument.expiration_month
        }.not_to raise_error
      end
    end
  end

  describe "#expiration_year" do
    it "returns the year from the expiration hash" do
      instrument = Lpt::Resources::Instrument.new(
        expiration: { month: "04", year: "2044" }
      )

      result = instrument.expiration_year

      expect(result).to eq("2044")
    end

    context "when the expiration is not set" do
      it "does not raise an error" do
        instrument = Lpt::Resources::Instrument.new(expiration: nil)

        expect {
          instrument.expiration_year
        }.not_to raise_error
      end
    end
  end

  describe "#auth" do
    before { configure_client }

    it "returns a truthy value" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      stub_payment_create

      result = instrument.auth(request)

      expect(result).to be_truthy
    end

    it "assigns the instrument ID to the request" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      allow(request).to receive(:instrument=).and_call_original
      stub_payment_create

      instrument.auth(request)

      expect(request).to have_received(:instrument=).once.with(instrument_id)
    end

    it "sends a payment auth request" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      stub_payment_create
      allow(Lpt::Resources::Payment).to receive(:auth)

      instrument.auth(request)

      expect(Lpt::Resources::Payment).to have_received(:auth).once.with(request)
    end

    context "when the instrument does not have an ID" do
      it "returns a falsy value" do
        instrument = Lpt::Resources::Instrument.new(id: nil)
        request = Lpt::Requests::PaymentRequest.new

        result = instrument.auth(request)

        expect(result).to be_falsy
      end
    end
  end

  describe "#charge" do
    before { configure_client }

    it "returns a truthy value" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      stub_payment_create

      result = instrument.charge(request)

      expect(result).to be_truthy
    end

    it "assigns the instrument ID to the request" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      allow(request).to receive(:instrument=).and_call_original
      stub_payment_create

      instrument.charge(request)

      expect(request).to have_received(:instrument=).once.with(instrument_id)
    end

    it "sends a sale payment request" do
      instrument_id = "LPI123123123123"
      instrument = Lpt::Resources::Instrument.new(id: instrument_id)
      request = Lpt::Requests::PaymentRequest.new
      stub_payment_create
      allow(Lpt::Resources::Payment).to receive(:sale)

      instrument.charge(request)

      expect(Lpt::Resources::Payment).to have_received(:sale).once.with(request)
    end

    context "when the instrument does not have an ID" do
      it "returns a falsy value" do
        instrument = Lpt::Resources::Instrument.new(id: nil)
        request = Lpt::Requests::PaymentRequest.new

        result = instrument.charge(request)

        expect(result).to be_falsy
      end
    end
  end

  describe ".token_path" do
    context "when not entity is passed in" do
      it "returns the base path" do
        result = Lpt::Resources::Instrument.token_path

        expect(result).to eq("/v2/instruments/token")
      end
    end

    context "when an entity is passed in" do
      it "returns the base path with the entity" do
        entity = "LEN123"

        result = Lpt::Resources::Instrument.token_path(entity: entity)

        expect(result).to eq("/v2/instruments/token/LEN123")
      end
    end
  end

  describe ".tokenize" do
    before { configure_client }

    it "returns the tokenized instrument" do
      token_id = "#{Lpt::PREFIX_TOKEN}XXXXXXXX"
      stub_instrument_tokenize token_id: token_id
      request = Lpt::Requests::InstrumentTokenRequest.new(
        account: "4242424242424242", security_code: "444",
        expiration: "04/2044"
      )

      result = Lpt::Resources::Instrument.tokenize(request)

      expect(result.id).to eq(token_id)
    end
  end

  describe ".retrieve" do
    before { configure_client }

    it "returns the existing instrument" do
      instrument_id = "#{Lpt::PREFIX_INSTRUMENT}123123123"
      stub_instrument_retrieve id: instrument_id

      result = Lpt::Resources::Instrument.retrieve(instrument_id)

      expect(result.id).to eq(instrument_id)
    end
  end

  describe ".create" do
    before { configure_client }

    it "returns the created instrument" do
      instrument_request = Lpt::Requests::InstrumentRequest.new
      stub_instrument_create

      result = Lpt::Resources::Instrument.create(instrument_request)

      expect(result.id).to be_present
    end
  end
end
