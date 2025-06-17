

module LPT
  module Resource
    module Create
      extend ActiveSupport::Concern

      # VALID_STATUSES = [ "public", "private", "archived" ]
      #
      # included do
      #   validates :status, inclusion: { in: VALID_STATUSES }
      # end

      included do

      end

      class_methods do
        def create(request, opts = {})
          if request.is_a? APIRequestModel
            params = request.as_compact_json
          else
            params = request
          end

          url = self.resource_url

          Rails.logger.debug "POST #{url} -- \n#{params}"

          client = LPT.client
          response = client.post(url, params)
          unless response.body
            return nil
          end

          resource = self.new(response.body)

          # Rails.logger.debug { "Client response: #{response.inspect}" }
          # Rails.logger.debug { "Profile: #{profile.inspect}" }

          resource
        end
      end
    end
  end
end
