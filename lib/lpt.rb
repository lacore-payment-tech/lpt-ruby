# frozen_string_literal: true

require "active_support/all"
require "delegate"
require "faraday"
require "logger"

require_relative "lpt/authentication"
require_relative "lpt/version"
require_relative "lpt/environment"
require_relative "lpt/lpt_client"

require_relative "lpt/api_operations/create"
require_relative "lpt/api_operations/retrieve"
require_relative "lpt/api_operations/update"

require_relative "lpt/resources/api_resource"
require_relative "lpt/resources/instrument"
require_relative "lpt/resources/payment"
require_relative "lpt/resources/profile"

require_relative "lpt/requests/api_request"
require_relative "lpt/requests/empty_request"
require_relative "lpt/requests/instrument_request"
require_relative "lpt/requests/instrument_token_request"
require_relative "lpt/requests/payment_request"
require_relative "lpt/requests/profile_request"

module Lpt
  class Error < StandardError; end

  DEFAULT_CA_BUNDLE_PATH = "#{__dir__}/data/ca-certificates.crt"

  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO
  LEVEL_TEST = -1

  PREFIX_ENTITY = "LEN"
  PREFIX_MERCHANT = "LMR"
  PREFIX_MERCHANT_ACCOUNT = "LMA"
  PREFIX_PROFILE = "LID"
  PREFIX_INSTRUMENT = "LPI"
  PREFIX_TOKEN = "LTK"
  PREFIX_PAYMENT = "LPY"
  PREFIX_VERIFICATION = "LPV"

  class << self
    include Lpt::Authentication

    attr_writer :open_timeout, :read_timeout, :write_timeout,
                :max_network_retries, :initial_network_retry_delay,
                :max_network_retry_delay, :verify_ssl_certs, :ca_bundle_path,
                :log_level

    delegate :api_base_url, to: :env

    def environment=(environment)
      standard_env = standardize_environment(environment)
      assert_environment_is_valid! standard_env
      @environment = standard_env
    end

    def environment
      @environment || Lpt::Environment::DEV
    end

    def api_version
      "v2"
    end

    def base_addresses(environment: nil)
      case environment
      when Lpt::Environment::PRODUCTION
        { api_base: "api-s2", cx_base: "cx", cx_api_base: "api.cx" }
      when Lpt::Environment::STAGING
        { api_base: "staging-api-s2", cx_base: "cx.stg",
          cx_api_base: "api.cx.stg" }
      else
        { api_base: "api", cx_base: "cx", cx_api_base: "api.cx" }
      end
    end

    def token_path(entity: nil)
      Lpt::Resources::Instrument.token_path(entity: entity)
    end

    def open_timeout
      @open_timeout || 30
    end

    def read_timeout
      @read_timeout || 80
    end

    def write_timeout
      @write_timeout || 30
    end

    def max_network_retries
      @max_network_retries || 2
    end

    def initial_network_retry_delay
      @initial_network_retry_delay || 0.5
    end

    def max_network_retry_delay
      @max_network_retry_delay || 5
    end

    def verify_ssl_certs
      @verify_ssl_certs || true
    end

    def ca_bundle_path
      @ca_bundle_path || DEFAULT_CA_BUNDLE_PATH
    end

    def log_level
      @log_level || LEVEL_DEBUG
    end

    protected

    def assert_environment_is_valid!(env)
      msg = "Invalid Environment: #{env}"
      raise ArgumentError, msg unless envs.include?(env)
    end

    def standardize_environment(env)
      return env if env.is_a? Integer

      Lpt::Environment::ENVIRONMENTS[env]
    end

    def envs
      Lpt::Environment::ENVIRONMENTS.values
    end

    def env
      @env ||= Lpt::Environment.factory(environment: environment)
    end
  end
end
