# frozen_string_literal: true

module LPT
  class Engine < ::Rails::Engine
    # isolate_namespace LPT
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

        ::LPT.environment = lpt_config.fetch(:environment, nil)
        env = ::LPT.environment
        Rails.logger.info "Loading environment from config file: #{env}"
        # if env
        #   ::LPT::Environment.active_env = ::LPT.environment
        # end
        ::LPT.client_init
      end

      if ::LPT.environment == nil
        Rails.logger.info "Environment not set from config file or initializer"
      else
        Rails.logger.info "Environment set from initializer!"
        ::LPT.client_init
      end

      #
      #
      # if ::LPT.environment === 'staging'
      #   ::LPT.api_base = ::LPT::Environment.base_url("staging-api-s2")
      #   ::LPT.cx_base = ::LPT::Environment.base_url("cx.stg")
      #   ::LPT.cx_api_base = ::LPT::Environment.base_url("api.cx.stg")
      # else
      #   ::LPT.api_base = ::LPT::Environment.base_url("api")
      #   ::LPT.cx_base = ::LPT::Environment.base_url("cx")
      #   ::LPT.cx_api_base = ::LPT::Environment.base_url("api.cx")
      # end
      #
      # ::LPT.base_addresses = {
      #   api: ::LPT.api_base,
      #   cx: ::LPT.cx_base,
      #   cx_api: ::LPT.cx_api_base,
      # }
      #
      # ::LPT.client_init
      #
      # client = ::LPT.client
      #
      #
      # Rails.logger.info LPT.base_addresses
    end
  end
end
