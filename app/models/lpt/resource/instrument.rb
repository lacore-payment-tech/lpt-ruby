# frozen_string_literal: true

module LPT
  module Resource
    class Instrument < APIResource
      include LPT::Resource::Retrieve
      include LPT::Resource::Create

      OBJECT_NAME = "instrument"
      def self.object_name
        "instrument"
      end

      def self.id_prefix
        "LPI"
      end

      def self.create_token(request, opts = {})
        if request.is_a? APIRequestModel
          params = request.as_compact_json
        else
          params = request
        end

        url = self.resource_url+"/token/"+ (::LPT.entity || '')

        puts "POST #{url} -- \n#{params}"

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


      attribute :entity, :string
      attribute :profile
      attribute :metadata
      attribute :instrument_id, :string
      attribute :reference_id, :string
      attribute :category, :string
      attribute :type, :string
      attribute :account_type, :string
      attribute :name, :name
      attribute :contact, :contact
      attribute :address, :address
      attribute :identifier
      attribute :brand, :string
      attribute :network, :string
      attribute :issuer_identifier
      attribute :issuer
      attribute :expiration
      attribute :fingerprint, :string


    end
  end
end
