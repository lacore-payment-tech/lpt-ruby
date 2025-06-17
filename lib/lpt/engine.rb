# frozen_string_literal: true

module LPT
  class Engine < ::Rails::Engine
    isolate_namespace LPT
    paths["app/models"] << "app/resources"

    config.after_initialize do
      begin
        lpt_config = Rails.application.config_for(:lpt)
      rescue
        lpt_config = nil
      end

      if lpt_config
        ::LPT.api_username ||= lpt_config.fetch(:username, nil)
        ::LPT.api_password ||= lpt_config.fetch(:password, nil)
        ::LPT.merchant ||= lpt_config.fetch(:merchant, nil)
        ::LPT.merchant_account ||= lpt_config.fetch(:merchant_account, nil)
        ::LPT.entity ||= lpt_config.fetch(:entity, nil)

        env = lpt_config.fetch(:environment, nil)
        puts "Environment from config: #{env}"
        if env
          ::LPT::Environment.active_env = env
        end
      end

      ::LPT.ca_bundle_path = ::LPT::DEFAULT_CA_BUNDLE_PATH
      # LPT.verify_ssl_certs = true

      ::LPT.max_network_retries = 2
      ::LPT.initial_network_retry_delay = 0.5
      ::LPT.max_network_retry_delay = 5

      ::LPT.open_timeout = 30
      ::LPT.read_timeout = 80
      ::LPT.write_timeout = 30

      ::LPT.api_base = ::LPT::Environment.base_url("api")
      ::LPT.cx_base = ::LPT::Environment.base_url("cx")
      ::LPT.cx_api_base = ::LPT::Environment.base_url("api.cx")
      ::LPT.base_addresses = {
        api: ::LPT.api_base,
        cx: ::LPT.cx_base,
        cx_api: ::LPT.cx_api_base,
      }
    end
  end
end
