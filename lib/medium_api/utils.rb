class MediumApi
  module Utils
    module_function

    def camelize_keys(object)
      object.each_with_object({}) do |(key, value), new_object|
        first_word, *to_camel_case = key.to_s.split('_')
        camelcase_key = [first_word, *to_camel_case.to_a.map(&:capitalize)].join
        camelcase_key = camelcase_key.to_sym if key.is_a?(Symbol)
        new_object[camelcase_key] = value
      end
    end

    def underscore_keys(object)
      object.each_with_object({}) do |(key, value), new_object|
        new_key = key.to_s.gsub(/([A-Z])/, '_\1').downcase
        new_key = new_key.to_sym if key.is_a?(Symbol)
        new_object[new_key] = value
      end
    end
  end
end
