# frozen_string_literal: true

module LPT
  class Profile < ApplicationRecord
    def self.create_from_model(model)
      self.new(model)
    end

    def load_from_model(model)
      self.attributes = {
        ext_id: model.profile_id,
        platform_ext_id: model.profile_id,
        reference_ext_id: model.reference_id,
        entity_ref: model.entity,

        name__full: model.name.full,
        name__prefix: model.name.prefix,
        name__first: model.name.first,
        name__middle: model.name.middle,
        name__last: model.name.last,
        name__generation: model.name.generation,
        name__suffix: model.name.suffix,
        name__locale: model.name.locale,

        contact__phone: model.phone,
        contact__email: model.email,

        address__line1: model.address.line1,
        address__line2: model.address.line2,
        address__line3: model.address.line3,
        address__city: model.address.city,
        address__subdivision: model.address.subdivision,
        address__postal_code: model.address.postal_code,
        address__country: model.address.country,

        status: model.status,
        created_at: model.created_at,
        updated_at: model.updated_at,
      }
    end
  end
end
