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
      "dev" => DEV
    }.freeze

    BASE_DOMAINS = {
      PRODUCTION => "lacorepayments.com",
      DEMO => "dmo.lacorepayments.com",
      STAGING => "lacorepayments.com",
      SANDBOX => "sbx.lacorepayments.com",
      NEXT => "nxt.lacorepayments.com",
      IVV => "ivv.lacorepayments.com",
      TEST => "test.lpt.local",
      DEV => "lpt.local"
    }.freeze

    attr_accessor :api_base, :cx_base, :cx_api_base, :base_domain

    def initialize(api_base: "", cx_base: "", cx_api_base: "", base_domain: "")
      @api_base = api_base
      @cx_base = cx_base
      @cx_api_base = cx_api_base
      @base_domain = base_domain
    end

    def ==(other)
      api_base == other.api_base && base_domain == other.base_domain &&
        cx_base == other.cx_base && cx_api_base == other.cx_api_base
    end

    def api_base_url(with_protocol: true)
      base_url(api_base, with_protocol: with_protocol)
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
        args = Lpt.base_addresses(environment: environment)
        args[:base_domain] = BASE_DOMAINS[environment]
        new(**args)
      end
    end

    protected

    def base_url(cname, with_protocol: true)
      protocol = "https://" if with_protocol
      "#{protocol}#{cname}.#{base_domain}"
    end
  end
end
