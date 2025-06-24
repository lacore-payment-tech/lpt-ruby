# frozen_string_literal: true

module Lpt
  class Environment
    PRODUCTION = 90
    DEMO = 80
    STAGING = 60
    SANDBOX = 50
    NEXT = 40
    IVV = 30
    TEST = 20
    DEV = 10

    ENVIRONMENTS = {
      "production" => PRODUCTION,
      "demo" => DEMO,
      "staging" => STAGING,
      "sandbox" => SANDBOX,
      "next" => NEXT,
      "ivv" => IVV,
      "test" => TEST,
      "dev" => DEV,
    }

    BASE_DOMAINS = {
      PRODUCTION => "lacorepayments.com",
      DEMO => "dmo.lacorepayments.com",
      STAGING => "lacorepayments.com", # "stg.lacorepayments.com",
      SANDBOX => "sbx.lacorepayments.com",
      NEXT => "nxt.lacorepayments.com",
      IVV => "ivv.lacorepayments.com",
      TEST => "test.lpt.local",
      DEV => "lpt.local" # "dev.lacorepayments.com",
    }

    attr_accessor :api_base, :cx_base, :cx_api_base, :base_domain

    def initialize(api_base:, cx_base:, cx_api_base:, base_domain:)
      @api_base = api_base
      @cx_base = cx_base
      @cx_api_base = cx_api_base
      @base_domain = base_domain
    end

    def api_base_url
      base_url(api_base)
    end

    def cx_base_url
      base_url(cx_base)
    end

    def cx_api_base_url
      base_url(cx_api_base)
    end

    class << self
      def staging
        factory(environment: STAGING)
      end

      def production
        factory(environment: PRODUCTION)
      end

      def factory(environment: DEV)
        args = base_addresses(environment: environment)
        puts "-- factory"
        puts args.inspect
        puts BASE_DOMAINS.inspect
        puts environment
        args[:base_domain] = BASE_DOMAINS[environment]
        puts args.inspect
        new(**args)
      end

      def base_addresses(environment:)
        if environment == STAGING
          { api_base: "staging-api-s2", cx_base: "cx.stg",
            cx_api_base: "api.cx.stg" }
        else
          { api_base: "api", cx_base: "cx", cx_api_base: "api.cx" }
        end
      end
    end

    protected

    def base_url(host)
      "https://#{host}.#{base_domain}/"
    end
  end
end
