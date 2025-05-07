# frozen_string_literal: true

require "rails"
# require "active_support/core_ext/numeric/time"
# require "active_support/dependencies"
# require "orm_adapter"
require "set"
require "securerandom"
# require "responders"
require "faraday"


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

  # class << self

    # mattr_accessor [
    #
    #                ], instance_accessor: false
    #
    # mattr_accessor [
    #
    #              ], instance_accessor: false

    # extend Forwardable
    #
    # attr_reader :config
    #
    #
    #
    # # User configurable options
    # def_delegators :@config, :api_username, :api_username=
    # def_delegators :@config, :api_password, :api_password=
    # def_delegators :@config, :entity, :entity=
    # def_delegators :@config, :merchant, :merchant=
    # def_delegators :@config, :environment, :environment=
    # def_delegators :@config, :logger, :logger=
    #
    # def_delegators :@config, :api_base, :api_base=
    # def_delegators :@config, :cx_base, :cx_base=
    # def_delegators :@config, :cx_api_base, :cx_api_base=
    # def_delegators :@config, :base_addresses, :base_addresses=
    # def_delegators :@config, :open_timeout, :open_timeout=
    # def_delegators :@config, :read_timeout, :read_timeout=
    # def_delegators :@config, :write_timeout, :write_timeout=
    # def_delegators :@config, :proxy, :proxy=
    # def_delegators :@config, :verify_ssl_certs, :verify_ssl_certs=
    # def_delegators :@config, :ca_bundle_path, :ca_bundle_path=
    # def_delegators :@config, :log_level, :log_level=
    # def_delegators :@config, :max_network_retries, :max_network_retries=
    #
    #
    # # Internal configurations
    # def_delegators :@config, :initial_network_retry_delay
    # def_delegators :@config, :max_network_retry_delay
    # def_delegators :@config, :ca_store
    # def initialize
    #   @@environment = LPT::Environment.active_env
    #   @@ca_bundle_path = LPT::DEFAULT_CA_BUNDLE_PATH
    #   @@verify_ssl_certs = true
    #
    #   @@max_network_retries = 2
    #   @@initial_network_retry_delay = 0.5
    #   @@max_network_retry_delay = 5
    #
    #   @@open_timeout = 30
    #   @@read_timeout = 80
    #   @@write_timeout = 30
    #
    #   @@api_base = LPT::Environment.base_url("api")
    #   @@cx_base = LPT::Environment.base_url("cx")
    #   @@cx_api_base = LPT::Environment.base_url("api.cx")
    #   @@base_addresses = {
    #     api: @@api_base,
    #     cx: @@cx_base,
    #     cx_api: @@cx_api_base,
    #   }
    # end


  # end
end
