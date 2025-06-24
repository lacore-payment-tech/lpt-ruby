# frozen_string_literal: true

module Lpt
  module Requests
    class ProfileRequest
      attr_accesor :metadata, :profile_id, :reference_id, :name, :contact,
                   :address
    end
  end
end
