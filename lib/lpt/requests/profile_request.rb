# frozen_string_literal: true

module Lpt
  module Requests
    class ProfileRequest < ApiRequest
      attr_accessor :metadata, :profile_id, :reference_id, :name, :contact,
                    :address
    end
  end
end
