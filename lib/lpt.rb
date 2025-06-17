# frozen_string_literal: true
require "lpt/version"
require "lpt/environment"
require "lpt/engine"

module LPT
  DEFAULT_CA_BUNDLE_PATH = __dir__ + "/data/ca-certificates.crt"

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  mattr_accessor :api_username
  @@api_username = nil

  mattr_accessor :api_password
  @@api_password = nil

  mattr_accessor :entity
  @@entity = nil

  mattr_accessor :merchant
  @@merchant = nil

  mattr_accessor :merchant_account
  @@merchant = nil


  mattr_accessor :environment
  @@environment = nil

  mattr_accessor :logger
  @@logger = nil

  mattr_accessor :api_base
  @@api_base = nil

  mattr_accessor :cx_base
  @@cx_base = nil

  mattr_accessor :cx_api_base
  @@cx_api_base = nil

  mattr_accessor :base_addresses
  @@base_addresses = { }

  mattr_accessor :open_timeout
  @@open_timeout = 30

  mattr_accessor :read_timeout
  @@read_timeout = 80

  mattr_accessor :write_timeout
  @@write_timeout = 30

  mattr_accessor :proxy
  @@proxy = nil

  mattr_accessor :verify_ssl_certs
  @@verify_ssl_certs = true

  mattr_accessor :ca_bundle_path
  @@ca_bundle_path = DEFAULT_CA_BUNDLE_PATH

  mattr_accessor :log_level
  @@log_level = LEVEL_DEBUG

  mattr_accessor :max_network_retries
  @@max_network_retries = 2

  mattr_accessor :initial_network_retry_delay
  @@initial_network_retry_delay = 0.5

  mattr_accessor :max_network_retry_delay
  @@max_network_retry_delay = 5

  mattr_accessor :ca_store

  mattr_reader :client
  @@client = nil

  def self.client
    @@client ||= begin
                   options = {
                     request: {
                       open_timeout: @@open_timeout,
                       read_timeout: @@read_timeout,
                       write_timeout: @@write_timeout,
                     }
                   }
                   Faraday.new(url: @@api_base, **options) do |config|
                     config.request :authorization, :basic, LPT.api_username,  LPT.api_password
                     config.request :json
                     config.response :json
                     config.response :raise_error
                     config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug do |fmt|
                       fmt.filter(/^(Buthorization: ).*$/i, '\1[REDACTED]')
                     end
                     config.adapter :net_http
                   end
                 end

    @@client
  end

  def self.client_reset
    @@client = nil
  end
end
