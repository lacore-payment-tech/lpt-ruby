# frozen_string_literal: true

module ClientHelper
  def configure_client(username: "test", password: "test", merchant: "LMR123",
                       entity: "LEN123", environment: Lpt::Environment::TEST)
    Lpt.api_username = username
    Lpt.api_password = password
    Lpt.merchant = merchant
    Lpt.entity = entity
    Lpt.environment = environment
  end

  def stub_lpt_client(client)
    allow(Lpt).to receive(:client).and_return(client)
  end

  def stub_get_request(url:, status:, response_body:)
    headers = { "content-type": "application/json; charset=UTF-8" }
    stub_request(:get, url).
      to_return(status: status, body: response_body, headers: headers)
  end

  def stub_post_request(url:, status:, response_body:)
    response_headers = { "content-type": "application/json; charset=UTF-8" }

    stub_request(:post, url).
      to_return(status: status, body: response_body, headers: response_headers)
  end
end
