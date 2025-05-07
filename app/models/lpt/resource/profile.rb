# frozen_string_literal: true

module LPT
  module Resource
    class Profile < APIResource
      include LPT::Resource::Retrieve
      include LPT::Resource::Create
      include LPT::Resource::Update

      OBJECT_NAME = "profile"
      def self.object_name
        "profile"
      end

      def self.id_prefix
        "LID"
      end

      attribute :entity, :string
      attribute :metadata
      attribute :profile_id, :string
      attribute :reference_id, :string
      attribute :name, :name
      attribute :contact, :contact
      attribute :address, :address

    end
  end
end
