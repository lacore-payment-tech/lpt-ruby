# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Authentication do
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
end
