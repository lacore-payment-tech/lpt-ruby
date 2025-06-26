# frozen_string_literal: true

module Lpt
  module Requests
    class VerificationRequest < ApiRequest
      attr_accessor :metadata,
                    :verification_id,
                    :reference_id,
                    :category,
                    :type,
                    :instrument,
                    :profile,
                    :subject,
                    :merchant,
                    :merchant_account,
                    :url
    end
  end
end
