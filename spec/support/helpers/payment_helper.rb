# frozen_string_literal: true

module PaymentHelper
  def stub_payment_capture(id: Lpt::PREFIX_PAYMENT)
    url = "https://api.test.lpt.local/v2/payments/#{id}/capture"
    stub_post_request url: url, status: 201, response_body: payment_response
  end

  def stub_payment_create
    stub_post_request url: "https://api.test.lpt.local/v2/payments",
                      status: 200,
                      response_body: payment_response
  end

  def stub_payment_refund(id: Lpt::PREFIX_PAYMENT)
    url = "https://api.test.lpt.local/v2/payments/#{id}/refund"
    stub_post_request url: url, status: 201, response_body: payment_response
  end

  def stub_payment_retrieve(id: Lpt::PREFIX_PAYMENT)
    stub_get_request url: "https://api.test.lpt.local/v2/payments/#{id}",
                     response_body: payment_response(id: id),
                     status: 200
  end

  def stub_payment_reverse(id: Lpt::PREFIX_PAYMENT)
    url = "https://api.test.lpt.local/v2/payments/#{id}/reverse"
    stub_post_request url: url, status: 201, response_body: payment_response
  end

  def stub_payment_void(id: Lpt::PREFIX_PAYMENT)
    url = "https://api.test.lpt.local/v2/payments/#{id}/void"
    stub_post_request url: url, status: 201, response_body: payment_response
  end

  def payment_response(id: Lpt::PREFIX_PAYMENT)
    <<~JSON
      {
        "id": "#{id}",
        "reference_id": "r7LN2Lz9t6dcCUHlYSnFs2Y-_eHGq"
      }
    JSON
  end
end
