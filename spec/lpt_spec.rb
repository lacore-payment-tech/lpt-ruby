# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt do
  it "has a version number" do
    expect(Lpt::VERSION).not_to be_nil
  end

  describe "#base_addresses" do
    context "when the environment is staging" do
      it "returns the staging base addresses" do
        staging_env = Lpt::Environment::STAGING
        staging_base = { api_base: "staging-api-s2", cx_base: "cx.stg",
                         cx_api_base: "api.cx.stg" }

        result = Lpt.base_addresses(environment: staging_env)

        expect(result).to eq(staging_base)
      end
    end

    context "when the environment is not staging" do
      it "returns the non-staging base addresses" do
        prod_env = Lpt::Environment::PRODUCTION
        non_staging_base = { api_base: "api", cx_base: "cx",
                             cx_api_base: "api.cx" }

        result = Lpt.base_addresses(environment: prod_env)

        expect(result).to eq(non_staging_base)
      end
    end
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
