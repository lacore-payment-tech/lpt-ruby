# frozen_string_literal: true

module LPT
  module Resource
    class VerificationRequest < APIRequestModel
      attribute :metadata
      attribute :verification_id
      attribute :reference_id
      attribute :category
      attribute :type
      attribute :instrument
      attribute :merchant
      attribute :merchant_account


    end
  end
end
