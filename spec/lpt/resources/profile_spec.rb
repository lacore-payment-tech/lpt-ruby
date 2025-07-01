# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Profile do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Profile.new

      expect(result.object_name).to be_present
    end
  end

  describe "#create_instrument" do
    before { configure_client }

    it "returns a truthy value" do
      profile_id = "LID123123123123"
      profile = Lpt::Resources::Profile.new(id: profile_id)
      request = Lpt::Requests::InstrumentTokenRequest.new(token: "TKN")
      stub_instrument_create

      result = profile.associate_instrument(request)

      expect(result).to be_truthy
    end

    it "assigns the profile to the request" do
      profile_id = "LID123123123123"
      profile = Lpt::Resources::Profile.new(id: profile_id)
      request = Lpt::Requests::InstrumentTokenRequest.new(token: "TKN")
      allow(request).to receive(:profile=).and_call_original
      stub_instrument_create

      profile.associate_instrument(request)

      expect(request).to have_received(:profile=).once.with(profile_id)
    end

    it "sends a create request" do
      profile_id = "LID123123123123"
      profile = Lpt::Resources::Profile.new(id: profile_id)
      request = Lpt::Requests::InstrumentTokenRequest.new(token: "TKN")
      stub_instrument_create

      result = profile.associate_instrument(request)

      expect(result.id).to be_present
    end

    context "when the profile does not have an ID" do
      it "returns a falsy value" do
        profile = Lpt::Resources::Profile.new(id: nil)
        request = Lpt::Requests::InstrumentTokenRequest.new(token: "TKN")
        stub_instrument_create

        result = profile.associate_instrument(request)

        expect(result).to be_falsy
      end
    end

    context "when the request does not have a token" do
      it "returns a falsy value" do
        profile = Lpt::Resources::Profile.new(id: "LID123123123")
        request = Lpt::Requests::InstrumentTokenRequest.new
        request.token = nil
        stub_instrument_create

        result = profile.associate_instrument(request)

        expect(result).to be_falsy
      end
    end
  end

  describe ".retrieve" do
    before { configure_client }

    it "returns the existing profile" do
      profile_id = "#{Lpt::PREFIX_PROFILE}123123123"
      stub_profile_retrieve id: profile_id

      result = Lpt::Resources::Profile.retrieve(profile_id)

      expect(result.id).to eq(profile_id)
    end
  end

  describe ".create" do
    before { configure_client }

    it "returns the created profile" do
      profile_request = Lpt::Requests::ProfileRequest.new
      stub_profile_create

      result = Lpt::Resources::Profile.create(profile_request)

      expect(result.id).to be_present
    end
  end
end
