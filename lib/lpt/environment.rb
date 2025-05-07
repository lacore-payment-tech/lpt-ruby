# frozen_string_literal: true

module LPT
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
      STAGING => "stg.lacorepayments.com",
      SANDBOX => "sbx.lacorepayments.com",
      NEXT => "nxt.lacorepayments.com",
      IVV => "ivv.lacorepayments.com",
      TEST => "test.lpt.local",
      DEV => "lpt.local" #"dev.lacorepayments.com",
    }

    cattr_accessor :ngrok, instance_accessor: false
    cattr_accessor :active_env, instance_accessor: false

    class << self
      @active_env = nil

      def active_env
        unless @active_env
          env = Rails.env
          case env
          when "production"
            @active_env = PRODUCTION
          when "development"
            @active_env = STAGING
          when "test"
            @active_env = STAGING
          else
            @active_env = DEV
          end
        end
        @active_env
      end
      def active_env=(new_env)
        unless new_env
          return
        end

        if new_env.is_a?(Integer)
          unless ENVIRONMENTS.has_value?(new_env)
            raise(ArgumentError, "Invalid LPT Environment: #{new_env}")
          end
          @active_env = new_env
        else
          key = new_env.to_s.downcase
          unless ENVIRONMENTS.has_key?(key)
            raise(ArgumentError, "Invalid LPT Environment: #{new_env}")
          end
          @active_env = ENVIRONMENTS[key]
        end
      end

      def base_url(host)
        "https://#{host}.#{base_domain}/"
      end

      def base_domain
        BASE_DOMAINS[active_env] || raise(ArgumentError, "Base Domain not set for environment: #{active_env}")
      end
    end
  end
end
