# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::LptClient do
  describe "#factory" do
    it "configures logging" do
      Lpt.log_level = Lpt::LEVEL_DEBUG
      env = Lpt::Environment.factory(environment: Lpt::Environment::STAGING)

      result = Lpt::LptClient.factory(environment: env).builder.handlers

      expect(result).to include(Faraday::Response::Logger)
    end

    context "when the log level is set to test" do
      it "does not configure logging" do
        Lpt.log_level = Lpt::LEVEL_TEST
        env = Lpt::Environment.factory(environment: Lpt::Environment::TEST)

        result = Lpt::LptClient.factory(environment: env).builder.handlers

        expect(result).not_to include(Faraday::Response::Logger)
      end
    end
  end
end
