module LPT
  module Resource
    module Retrieve
      extend ActiveSupport::Concern

      # VALID_STATUSES = [ "public", "private", "archived" ]
      #
      # included do
      #   validates :status, inclusion: { in: VALID_STATUSES }
      # end

      included do
        def refresh
          url = resource_url

          client = LPT.client
          response = client.get(url)
          unless response.body
            return nil
          end

          attributes = response.body

          # Rails.logger.debug { "Client response: #{response.inspect}" }
          # Rails.logger.debug { "Profile: #{profile.inspect}" }

          self
        end
      end

      class_methods do
        def retrieve(id, opts = {})
          resource = new({ id: id })
          url = resource.resource_url

          client = LPT.client
          response = client.get(url)
          unless response.body
            return nil
          end

          resource.attributes = response.body

          # Rails.logger.debug { "Client response: #{response.inspect}" }
          # Rails.logger.debug { "Profile: #{profile.inspect}" }

          resource
        end
      end
    end
  end
end
