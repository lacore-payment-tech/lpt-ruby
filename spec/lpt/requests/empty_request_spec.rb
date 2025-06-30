# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Requests::EmptyRequest do
  describe "#to_json" do
    it "returns nothing" do
      request = Lpt::Requests::EmptyRequest.new

      result = request.to_json

      expect(result).to be_blank
    end
  end
end
