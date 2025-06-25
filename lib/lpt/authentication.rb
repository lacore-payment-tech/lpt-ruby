# frozen_string_literal: true

module Lpt
  module Authentication
    attr_accessor :api_username, :api_password, :merchant, :merchant_account,
                  :entity

    def client
      assert_client_is_configured!
      env = Lpt::Environment.factory(environment: environment)
      Lpt::LptClient.factory(environment: env)
    end

    protected

    def assert_client_is_configured!
      assert_username!
      assert_password!
      assert_merchant!
      assert_entity!
    end

    def assert_username!
      msg = "Invalid API Username: #{api_username}"
      raise ArgumentError, msg if api_username.blank?
    end

    def assert_password!
      msg = "Invalid API Password"
      raise ArgumentError, msg if api_password.blank?
    end

    def assert_merchant!
      msg = "Invalid Merchant: #{merchant}"
      raise ArgumentError, msg unless merchant.start_with? PREFIX_MERCHANT
    end

    def assert_entity!
      msg = "Invalid Entity: #{entity}"
      raise ArgumentError, msg unless entity.start_with? PREFIX_ENTITY
    end
  end
end
