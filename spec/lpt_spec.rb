# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt do
  it "has a version number" do
    expect(Lpt::VERSION).not_to be nil
  end

  describe "#environment=" do
    context "when the environment is a valid integer" do
      it "sets the value" do
        env = 90

        Lpt.environment = env

        expect(Lpt.environment).to eq(Lpt::Environment::PRODUCTION)
      end
    end
    context "when the environment is an invalid integer" do
      it "raises an error" do
        env = 66

        expect {
          Lpt.environment = env
        }.to raise_error(ArgumentError)
      end
    end

    context "when the environment is a valid string" do
      it "sets the environment" do
        env = "production"

        Lpt.environment = env

        expect(Lpt.environment).to eq(Lpt::Environment::PRODUCTION)
      end
    end

    context "when the environment is an invalid string" do
      it "raises an error" do
        env = "nada"

        expect {
          Lpt.environment = env
        }.to raise_error(ArgumentError)
      end
    end
  end
end
