module XlsFunction
  module FormatString
    module TransformRules
      module Numbers
        def self.included(klass)
          klass.class_eval do
            rule(digit_s: simple(:digit_s)) do
              (->(input) do
                s = input.to_s
                s == '0' ? '' : s
              end).tap do |p|
                p.extend DigitConcern
              end
            end

            rule(digit_z: simple(:digit_z)) do
              (->(input) do
                s = input.to_s
                s != '' ? s : '0'
              end).tap do |p|
                p.extend DigitConcern
              end
            end

            rule(digit_q: simple(:digit_q)) do
              (->(input) do
                s = input.to_s
                s != '' ? s : ' '
              end).tap do |p|
                p.extend DigitConcern
              end
            end

            rule(number: subtree(:number)) { number }

            # 1 number and 1 suffix patterns such as '0%'
            rule(number: subtree(:number), string: simple(:string)) do
              [number, ->(_) { string }]
            end

            rule(texts: subtree(:texts), number: subtree(:number)) do
              [texts, number]
            end

            rule(numbers: subtree(:numbers)) do
              ::XlsFunction::FormatString::Evaluators::NumberEvaluator.new(Array(numbers).flatten)
            end
          end
        end

        module DigitConcern
          def digits?
            true
          end
        end
      end
    end
  end
end
