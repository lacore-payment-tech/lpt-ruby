# frozen_string_literal: true

require "spec_helper"

RSpec.describe Lpt::Environment do
  describe "#==" do
    context "when the attributes match" do
      it "is equal" do
        env1 = Lpt::Environment.new(api_base: "a", cx_base: "c",
                                    cx_api_base: "d", base_domain: "e")
        env2 = Lpt::Environment.new(api_base: "a", cx_base: "c",
                                    cx_api_base: "d", base_domain: "e")

        expect(env1).to eq(env2)
      end
    end

    context "when the attributes do not match" do
      it "is not equal" do
        env1 = Lpt::Environment.new(api_base: "a", cx_base: "c",
                                    cx_api_base: "d", base_domain: "e")
        env2 = Lpt::Environment.new(api_base: "p", cx_base: "c",
                                    cx_api_base: "d", base_domain: "e")

        expect(env1).not_to eq(env2)
      end
    end
  end

  describe "#api_base_url" do
    it "builds the full url" do
      environment = Lpt::Environment.new(api_base: "testing",
                                         base_domain: "lpt.io")

      result = environment.api_base_url

      expect(result).to eq("https://testing.lpt.io/")
    end
  end

  describe "#cx_base_url" do
    it "builds the full url" do
      environment = Lpt::Environment.new(cx_base: "cx.testing",
                                         base_domain: "lpt.io")

      result = environment.cx_base_url

      expect(result).to eq("https://cx.testing.lpt.io/")
    end
  end

  describe "#cx_api_base_url" do
    it "builds the full url" do
      environment = Lpt::Environment.new(cx_api_base: "cx.api.testing",
                                         base_domain: "lpt.io")

      result = environment.cx_api_base_url

      expect(result).to eq("https://cx.api.testing.lpt.io/")
    end
  end

  describe ".factory" do
    it "sets the base domain for the environment" do
      base_domains = { Lpt::Environment::TEST => "testing.local" }
      stub_const "Lpt::Environment::BASE_DOMAINS", base_domains
      test_env = Lpt::Environment::TEST

      environment = Lpt::Environment.factory(environment: test_env)

      expect(environment.base_domain).to eq("testing.local")
    end

    it "sets the api base for the environment" do
      stub_base_addresses api_base: "api"
      test_env = Lpt::Environment::TEST

      environment = Lpt::Environment.factory(environment: test_env)

      expect(environment.api_base).to eq("api")
    end

    it "sets the cx base for the environment" do
      stub_base_addresses cx_base: "cx"
      test_env = Lpt::Environment::TEST

      environment = Lpt::Environment.factory(environment: test_env)

      expect(environment.cx_base).to eq("cx")
    end

    it "sets the cx api base for the environment" do
      stub_base_addresses cx_api_base: "cx.api"
      test_env = Lpt::Environment::TEST

      environment = Lpt::Environment.factory(environment: test_env)

      expect(environment.cx_api_base).to eq("cx.api")
    end
  end

  def stub_base_addresses(api_base: "", cx_base: "", cx_api_base: "")
    base = { api_base: api_base, cx_base: cx_base, cx_api_base: cx_api_base }
    allow(Lpt).to receive(:base_addresses).and_return(base)
  end
end
