# frozen_string_literal: true

module Lpt
  class LptClient
    def initialize(api_client:)
      @api_client = api_client
    end

    class << self
      def factory(env:)
        request_options = { open_timeout: Lpt.open_timeout,
                            read_timeout: Lpt.read_timeout,
                            write_timeout: Lpt.write_timeout }
        options = { request: request_options }
        logging_options = { headers: true, bodies: true,
                            log_level: Lpt.log_level }
        username = Lpt.api_username
        password = Lpt.api_password

        client = Faraday.new(url: env.api_base_url, **options) do |config|
          config.request :authorization, :basic, username, password
          config.request :json
          config.response :json
          config.response :raise_error
          config.response :logger, nil, **logging_options do |fmt|
            fmt.filter(/^(Buthorization: ).*$/i, '\1[REDACTED]')
          end
          config.adapter :net_http
        end

        new(api_client: client)
      end
    end
  end
end
