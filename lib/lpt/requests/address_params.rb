# frozen_string_literal: true

module Lpt
  module Requests
    class AddressParams < Params
      attr_accessor :line1, :line2, :line3, :city, :subdivision, :postal_code,
                    :country
    end
  end
end
