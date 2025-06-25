# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Profile do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Profile.new

      expect(result.object_name).to be_present
    end
  end

  describe ".retrieve" do
    before { configure_client }

    it "returns the existing profile" do
      profile_id = "LID123123123"
      stub_profile_retrieve id: profile_id

      result = Lpt::Resources::Profile.retrieve(profile_id)

      expect(result.id).to eq(profile_id)
    end
  end

  describe ".create" do
    before { configure_client }

    it "returns the created profile" do
      profile_request = Lpt::Requests::ProfileRequest.new
      stub_profile_create request: profile_request

      result = Lpt::Resources::Profile.create(profile_request)

      expect(result.id).to be_present
    end
  end
end
