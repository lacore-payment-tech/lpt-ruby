# frozen_string_literal: true
module LPT
  module Resource
    module Type
      class Name < APIValue
        attr_accessor :full
        attr_accessor :prefix
        attr_accessor :first
        attr_accessor :middle
        attr_accessor :last
        attr_accessor :generation
        attr_accessor :suffix
        attr_accessor :locale

        def type
          :name
        end

        def hash
          {
            :full => @full,
            :prefix => @prefix,
            :first => @first,
            :middle => @middle,
            :last => @last,
            :generation => @generation,
            :suffix => @suffix,
            :locale => @locale,
          }
        end

        def serialize(value)
          hash
        end

        # def serializable?(value)
        #   false
        # end

        def value_constructed_by_mass_assignment?(value)
          value.is_a?(Hash)
        end

        private
        def cast_value(value)
          if value.is_a?(String)
            @full = value
            @prefix = nil
            @first = nil
            @middle = nil
            @last = nil
            @generation = nil
            @suffix = nil
            @locale = nil
          else
            @full = value.fetch("full", nil)
            @prefix = value.fetch("prefix", nil)
            @first = value.fetch("first", nil)
            @middle = value.fetch("middle", nil)
            @last = value.fetch("last", nil)
            @generation = value.fetch("generation", nil)
            @suffix = value.fetch("suffix", nil)
            @locale = value.fetch("locale", nil)
          end

          self
        end
      end
    end
  end
end
