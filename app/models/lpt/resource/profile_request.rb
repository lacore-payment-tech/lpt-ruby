# frozen_string_literal: true

module LPT
  module Resource
    class ProfileRequest < APIRequestModel
      attribute :metadata
      attribute :profile_id
      attribute :reference_id
      attribute :name
      attribute :contact
      attribute :address


    end
  end
end
