
module LPT
  class LPTController < ApplicationController
    def self.check_access
      client = LPT.client
      response = client.get(LPT.api_base)

      return response
    end
  end
end
