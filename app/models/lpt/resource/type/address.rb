module LPT
  module Resource
    module Type
      class Address < APIValue
        attr_accessor :line1
        attr_accessor :line2
        attr_accessor :line3
        attr_accessor :city
        attr_accessor :subdivision
        attr_accessor :postal_code
        attr_accessor :country

        def type
          :address
        end

        def hash
          {
            :line1 => @line1,
            :line2 => @line2,
            :line3 => @line3,
            :city => @city,
            :subdivision => @subdivision,
            :postal_code => @postal_code,
            :country => @country,
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
          @line1 = value.fetch("line1", nil)
          @line2 = value.fetch("line2", nil)
          @line3 = value.fetch("line3", nil)
          @city = value.fetch("city", nil)
          @subdivision = value.fetch("subdivision", nil)
          @postal_code = value.fetch("postal_code", nil)
          @country = value.fetch("country", nil)

          self
        end
      end
    end
  end
end

