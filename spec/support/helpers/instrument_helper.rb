# frozen_string_literal: true

module InstrumentHelper
  def stub_instrument_retrieve(id: Lpt::PREFIX_INSTRUMENT)
    stub_get_request url: "https://api.test.lpt.local/v2/instruments/#{id}",
                     response_body: instrument_response(id: id),
                     status: 200
  end

  def stub_instrument_create
    stub_post_request url: "https://api.test.lpt.local/v2/instruments",
                      status: 201,
                      response_body: instrument_response
  end

  def stub_instrument_tokenize(token_id: Lpt::PREFIX_TOKEN)
    stub_post_request url: "https://api.test.lpt.local/v2/instruments/token",
                      status: 201,
                      response_body: instrument_response(id: token_id)
  end

  def instrument_response(id: Lpt::PREFIX_INSTRUMENT)
    <<~JSON
      {
        "id": "#{id}"
      }
    JSON
  end
end
