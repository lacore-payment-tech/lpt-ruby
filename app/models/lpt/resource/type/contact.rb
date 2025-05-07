# frozen_string_literal: true

module LPT
  module Resource
    module Type
      class Contact < APIValue
        attr_accessor :phone
        attr_accessor :fax
        attr_accessor :email
        attr_accessor :website

        def type
          :contact
        end

        def hash
          {
            :phone => @phone,
            :fax => @fax,
            :email => @email,
            :website => @website,
          }
        end

        def serializable?(value)
          false
        end

        def value_constructed_by_mass_assignment?(value)
          value.is_a?(Hash)
        end

        private
        def cast_value(value)
          @phone = value.fetch("phone", nil)
          @fax = value.fetch("fax", nil)
          @email = value.fetch("email", nil)
          @website = value.fetch("website", nil)

          self
        end
      end
    end
  end
end
