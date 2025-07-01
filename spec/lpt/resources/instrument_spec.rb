# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Instrument do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Instrument.new

      expect(result.object_name).to be_present
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
