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
end
