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
  # @@api_username = nil

  mattr_accessor :api_password
  # @@api_password = nil

  mattr_accessor :entity
  # @@entity = nil

  mattr_accessor :merchant
  # @@merchant = nil

  mattr_accessor :merchant_account
  # @@merchant_account = nil


  mattr_accessor :environment
  # @@environment = nil

  mattr_accessor :logger
  # @@logger = nil

  mattr_accessor :api_base
  # @@api_base = nil

  mattr_accessor :cx_base
  # @@cx_base = nil

  mattr_accessor :cx_api_base
  # @@cx_api_base = nil

  mattr_accessor :base_addresses, default: { }
  # @@base_addresses = { }

  mattr_accessor :open_timeout, default: 30
  # @@open_timeout = 30

  mattr_accessor :read_timeout, default: 80
  # @@read_timeout = 80

  mattr_accessor :write_timeout, default: 30
  # @@write_timeout = 30

  mattr_accessor :max_network_retries, default: 2
  # @@max_network_retries = 2

  mattr_accessor :initial_network_retry_delay, default: 0.5
  # @@initial_network_retry_delay = 0.5

  mattr_accessor :max_network_retry_delay, default: 5
  # @@max_network_retry_delay = 5

  mattr_accessor :proxy
  # @@proxy = nil

  mattr_accessor :verify_ssl_certs, default: true
  # @@verify_ssl_certs = true

  mattr_accessor :ca_bundle_path
  @@ca_bundle_path = DEFAULT_CA_BUNDLE_PATH

  mattr_accessor :log_level
  @@log_level = LEVEL_DEBUG

  mattr_accessor :ca_store

  mattr_reader :client, instance_reader: false, instance_accessor: false
  # @@client = nil

  # def self.client_init
  #   @@client ||= begin
  #                  options = {
  #                    request: {
  #                      open_timeout: @@open_timeout,
  #                      read_timeout: @@read_timeout,
  #                      write_timeout: @@write_timeout,
  #                    }
  #                  }
  #                  Faraday.new(url: @@api_base, **options) do |config|
  #                    config.request :authorization, :basic, @@api_username,  @@api_password
  #                    config.request :json
  #                    config.response :json
  #                    config.response :raise_error
  #                    config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug do |fmt|
  #                      fmt.filter(/^(Buthorization: ).*$/i, '\1[REDACTED]')
  #                    end
  #                    config.adapter :net_http
  #                  end
  #                end
  #
  #   @@client
  # end
  #
  # def self.client_reset
  #   @@client = nil
  # end
  #
  # # @param conf [Class<Hash>|Class<ActiveSupport::OrderedOptions>]
  # def self.configure(conf = nil)
  #   if conf == nil
  #     raise("Configuration attempted with empty param hash")
  #   end
  #
  #   @@ca_bundle_path = ::LPT::DEFAULT_CA_BUNDLE_PATH
  #   # LPT.verify_ssl_certs = true
  #
  #   @@api_username = conf.api_username
  #   @@api_password = conf.api_password
  #   @@merchant = conf.merchant
  #   @@merchant_account = conf.merchant_account
  #   @@entity = conf.entity
  #   @@environment = conf.environment || 'dev'
  #
  #   ::LPT::Environment.active_env = @@environment
  #
  #   @@max_network_retries = conf.max_network_retries || 2
  #   @@initial_network_retry_delay = conf.initial_network_retry_delay || 0.5
  #   @@max_network_retry_delay = conf.max_network_retry_delay || 5
  #
  #   @@open_timeout  = conf.open_timeout || 30
  #   @@read_timeout  = conf.read_timeout || 80
  #   @@write_timeout = conf.write_timeout || 30
  #
  #   if @@environment === 'staging'
  #     @@api_base = ::LPT::Environment.base_url("staging-api-s2")
  #     @@cx_base = ::LPT::Environment.base_url("cx.stg")
  #     @@cx_api_base = ::LPT::Environment.base_url("api.cx.stg")
  #   else
  #     @@api_base = ::LPT::Environment.base_url("api")
  #     @@cx_base = ::LPT::Environment.base_url("cx")
  #     @@cx_api_base = ::LPT::Environment.base_url("api.cx")
  #   end
  #
  #   @@base_addresses = {
  #     api: @@api_base,
  #     cx: @@cx_base,
  #     cx_api: @@cx_api_base,
  #   }
  #
  #   @@client = nil
  #
  #   self.client_init
  #
  #   return nil
  # end

  # def configure(conf = nil)
  #   return LPT.configure(conf)
  # end

  # class << self
    def configure(conf = nil)
      if conf == nil
        raise("Configuration attempted with empty param hash")
      end

      @@ca_bundle_path = ::LPT::DEFAULT_CA_BUNDLE_PATH
      # LPT.verify_ssl_certs = true

      @@api_username = conf.api_username
      @@api_password = conf.api_password
      @@merchant = conf.merchant
      @@merchant_account = conf.merchant_account
      @@entity = conf.entity
      @@environment = conf.environment || 'dev'

      ::LPT::Environment.active_env = @@environment

      @@max_network_retries = conf.max_network_retries || 2
      @@initial_network_retry_delay = conf.initial_network_retry_delay || 0.5
      @@max_network_retry_delay = conf.max_network_retry_delay || 5

      @@open_timeout  = conf.open_timeout || 30
      @@read_timeout  = conf.read_timeout || 80
      @@write_timeout = conf.write_timeout || 30

      if @@environment === 'staging'
        @@api_base = ::LPT::Environment.base_url("staging-api-s2")
        @@cx_base = ::LPT::Environment.base_url("cx.stg")
        @@cx_api_base = ::LPT::Environment.base_url("api.cx.stg")
      else
        @@api_base = ::LPT::Environment.base_url("api")
        @@cx_base = ::LPT::Environment.base_url("cx")
        @@cx_api_base = ::LPT::Environment.base_url("api.cx")
      end

      @@base_addresses = {
        api: LPT::api_base,
        cx: LPT::cx_base,
        cx_api: LPT::cx_api_base,
      }

      @@client = nil

      self.client_init

      return nil
    end

    def client_init
      @@client ||= begin
                     options = {
                       request: {
                         open_timeout: @@open_timeout,
                         read_timeout: @@read_timeout,
                         write_timeout: @@write_timeout,
                       }
                     }
                     Faraday.new(url: @@api_base, **options) do |config|
                       config.request :authorization, :basic, @@api_username,  @@api_password
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

    def client_reset
      @@client = nil
    end
  # end
end

class LPTClient
  extend LPT
end