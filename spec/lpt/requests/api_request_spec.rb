# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Requests::ApiRequest do
  describe "#initialize" do
    it "assigns the entity" do
      Lpt.entity = "LEN123123123"
      result = Lpt::Requests::ApiRequest.new

      expect(result.entity).to eq("LEN123123123")
    end
  end
end
