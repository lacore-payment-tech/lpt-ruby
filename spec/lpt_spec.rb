# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt do
  it "has a version number" do
    expect(Lpt::VERSION).not_to be_nil
  end

  describe "#client" do
    it "instantiates the environment" do
      configure_client
      allow(Lpt::Environment).to receive(:factory).and_call_original
      Lpt.environment = Lpt::Environment::STAGING

      Lpt.client

      expect(Lpt::Environment).to have_received(:factory).once.
        with(environment: Lpt::Environment::STAGING)
    end

    it "instantiates the LPT client" do
      configure_client
      allow(Lpt::LptClient).to receive(:factory).and_call_original
      environment = Lpt::Environment.staging
      Lpt.environment = Lpt::Environment::STAGING

      Lpt.client

      expect(Lpt::LptClient).to have_received(:factory).once.
        with(environment: environment)
    end

    context "when the username is not set" do
      it "raises an error" do
        configure_client username: ""

        expect {
          Lpt.client
        }.to raise_error(ArgumentError)
      end
    end

    context "when the password is not set" do
      it "raises an error" do
        configure_client password: ""

        expect {
          Lpt.client
        }.to raise_error(ArgumentError)
      end
    end

    context "when the merchant is invalid" do
      it "raises an error" do
        configure_client merchant: "XXXMR123"

        expect {
          Lpt.client
        }.to raise_error(ArgumentError)
      end
    end

    context "when the entity is invalid" do
      it "raises an error" do
        configure_client entity: "XXXABV"

        expect {
          Lpt.client
        }.to raise_error(ArgumentError)
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

  def configure_client(username: "test", password: "test", merchant: "LMR123",
                       entity: "LEN123")
    Lpt.api_username = username
    Lpt.api_password = password
    Lpt.merchant = merchant
    Lpt.entity = entity
  end
end
