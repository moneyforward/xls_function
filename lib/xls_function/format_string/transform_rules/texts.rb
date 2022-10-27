module XlsFunction
  module FormatString
    module TransformRules
      module Texts
        def self.included(klass)
          klass.class_eval do
            rule(placeholder: simple(:placeholder)) do
              ->(input) { input.to_s }
            end

            rule(string: simple(:string)) do
              ->(_input) { string.to_s }
            end

            rule(text: subtree(:text)) { text }

            rule(texts: subtree(:texts)) do
              ->(input) { texts.map { |text| text.call(input) }.join }
            end
          end
        end
      end
    end
  end
end
