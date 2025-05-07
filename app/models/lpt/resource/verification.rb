# frozen_string_literal: true

module LPT
  module Resource
    class Verification < APIResource
      include LPT::Resource::Retrieve
      OBJECT_NAME = "verification"
      def self.object_name
        "verification"
      end

      def self.id_prefix
        "LPV"
      end

      attribute :entity, :string
      attribute :metadata
      attribute :verification_id, :string
      attribute :reference_id, :string
      attribute :subject
      attribute :profile
      attribute :instrument
      attribute :merchant
      attribute :merchant_account
      attribute :category
      attribute :type
      attribute :url
      attribute :result
      attribute :verified



    end
  end
end
