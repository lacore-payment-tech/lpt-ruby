module LPT
  class ArrayHelper
    def self.compact_recursive(obj = {})
      obj.each_with_object({}) do |(k, v), squeezed_hash|
        if v.is_a?(Hash)
          squeezed_hash[k] = compact_recursive(v)
        else
          squeezed_hash[k] = v unless v.nil?
        end
      end
    end
  end
end
