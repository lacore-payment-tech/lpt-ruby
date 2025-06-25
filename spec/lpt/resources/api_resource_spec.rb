# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::ApiResource do
  describe "#base_path" do
    it "returns the API version" do
      allow(Lpt).to receive(:api_version).and_return("vvv")

      result = Lpt::Resources::ApiResource.new

      expect(result.base_path).to eq("/vvv")
    end
  end

  describe "#resources_path" do
    it "raises an error" do
      abstract_resource = Lpt::Resources::ApiResource.new

      expect {
        abstract_resource.resources_path
      }.to raise_error(NotImplementedError)
    end
  end

  describe "#resource_path" do
    it "raises an error" do
      abstract_resource = Lpt::Resources::ApiResource.new

      expect {
        abstract_resource.resource_path
      }.to raise_error(NotImplementedError)
    end
  end
end
