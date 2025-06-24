# frozen_string_literal: true

require "faraday"
require "logger"

require_relative "lpt/version"
require_relative "lpt/environment"
require_relative "lpt/lpt_client"

module Lpt
  class Error < StandardError; end

  DEFAULT_CA_BUNDLE_PATH = "#{__dir__}/data/ca-certificates.crt"

  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  class << self
    attr_accessor :api_username, :api_password, :merchant, :merchant_account,
                  :entity

    attr_accessor :environment, :logger, :proxy, :ca_store

    attr_writer :open_timeout, :read_timeout, :write_timeout,
                :max_network_retries, :initial_network_retry_delay,
                :max_network_retry_delay, :verify_ssl_certs, :ca_bundle_path,
                :log_level

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
  end
end
