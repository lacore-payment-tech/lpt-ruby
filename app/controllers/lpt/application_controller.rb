module LPT
  class ApplicationController < ActionController::Base
    def initialize
      Rails.logger.debug "ApplicationController initialized"
    end
  end
end
