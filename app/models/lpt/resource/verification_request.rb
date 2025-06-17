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
      attribute :profile
      attribute :subject
      attribute :merchant
      attribute :merchant_account
      attribute :url


    end
  end
end
