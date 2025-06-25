# frozen_string_literal: true

module Lpt
  class LptClient < ::SimpleDelegator
    def initialize(api_client:)
      super(api_client)
    end

    class << self
      def factory(environment:)
        options = { request: request_options }
        client = initialize_client(api_base_url: environment.api_base_url,
                                   options: options)
        new(api_client: client)
      end

      protected

      def request_options
        { open_timeout: Lpt.open_timeout, read_timeout: Lpt.read_timeout,
          write_timeout: Lpt.write_timeout }
      end

      def logging_options
        { headers: true, bodies: true, log_level: Lpt.log_level }
      end

      def initialize_client(api_base_url:, options:)
        Faraday.new(url: api_base_url, **options) do |config|
          config.request :authorization, :basic, Lpt.api_username, Lpt.api_password
          config.request :json
          config.response :json
          config.response :raise_error
          config.adapter :net_http
        end
      end
    end
  end
end
