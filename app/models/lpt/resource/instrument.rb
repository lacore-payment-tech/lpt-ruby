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
      attribute :brand
      attribute :network
      attribute :issuer_identifier
      attribute :issuer
      attribute :expiration
      attribute :fingerprint

    end
  end
end
