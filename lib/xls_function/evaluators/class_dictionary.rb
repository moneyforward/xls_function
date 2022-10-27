module XlsFunction
  module Evaluators
    module ClassDictionary
      def self.included(klass)
        klass.class_eval do
          class << self
            def register_dictionary(key, value = self)
              @register_key = key
              dictionary[key] = value
            end

            def from_dictionary(key)
              dictionary[key]
            end

            def description(text)
              @description = text
            end

            private

            def dictionary
              XlsFunction.class_dictionary
            end
          end
        end
      end
    end
  end
end
