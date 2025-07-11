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

      def configure_request(config)
        config.request :authorization, :basic, Lpt.api_username, Lpt.api_password
        config.request :json
      end

      def configure_response(config)
        config.response :json
        config.response :raise_error
      end

      def configure_logging(config)
        return if Lpt.log_level.negative?

        config.response :logger, nil, **logging_options do |fmt|
          fmt.filter(/^(Authorization: ).*$/i, '\1[REDACTED]')
        end
      end

      def assign_adapter(config)
        config.adapter :net_http
      end

      def initialize_client(api_base_url:, options:)
        Faraday.new(url: api_base_url, **options) do |config|
          configure_request config
          configure_response config
          configure_logging config
          assign_adapter config
        end
      end
    end
  end
end
