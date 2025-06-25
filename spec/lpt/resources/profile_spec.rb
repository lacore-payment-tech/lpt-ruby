# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Resources::Profile do
  describe "#initialize" do
    it "assigns the object name" do
      result = Lpt::Resources::Profile.new

      expect(result.object_name).to be_present
    end
  end
end
