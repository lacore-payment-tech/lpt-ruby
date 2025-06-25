# frozen_string_literal: true

module ProfileHelper
  def stub_profile_retrieve(id: "LID")
    stub_get_request url: "https://api.test.lpt.local/v2/profiles/#{id}",
                     response_body: profile_response(id: id),
                     status: 200
  end

  def stub_profile_create(request:)
    stub_post_request url: "https://api.test.lpt.local/v2/profiles",
                      request_body: request.to_json,
                      status: 200,
                      response_body: profile_response
  end

  def profile_response(id: "LIDXXXXXXXXXXX")
    <<~JSON
      {
        "id": "#{id}",
        "entity": "LEN690aa4875b804aef828bc9d5affec373",
        "name": {
            "full": "Test Customer",
            "first": "Test",
            "last": "Customer"
        },
        "contact": {
            "phone": "+15555555555",
            "email": "testcustomer@example.com"
        },
        "created": "2025-06-25T18:23:31Z",
        "updated": "2025-06-25T18:23:31Z",
        "status": "ACTIVE",
        "created_at": 1750875811,
        "updated_at": 1750875811
      }
    JSON
  end
end
