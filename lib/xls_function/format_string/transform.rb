require 'xls_function/format_string/evaluators/number_evaluator'
require 'xls_function/format_string/evaluators/time_evaluator'
require 'xls_function/format_string/evaluators/elapsed_time_evaluator'

require 'xls_function/format_string/transform_rules/texts'
require 'xls_function/format_string/transform_rules/numbers'
require 'xls_function/format_string/transform_rules/dates'
require 'xls_function/format_string/transform_rules/times'

module XlsFunction
  module FormatString
    class Transform < Parslet::Transform
      include ::XlsFunction::FormatString::TransformRules::Texts
      include ::XlsFunction::FormatString::TransformRules::Numbers
      include ::XlsFunction::FormatString::TransformRules::Dates
      include ::XlsFunction::FormatString::TransformRules::Times

      rule(for_all: subtree(:for_all)) do
        ->(input) do
          result = for_all.map { |expr| expr.call(input) }.join
          result != '' ? result : input
        end
      end

      rule(for_plus_and_zero: subtree(:for_plus_and_zero), for_minus: subtree(:for_minus)) do
        ->(input) do
          try_result, value = ::XlsFunction::Converters::NumberConverter.try_convert(input)
          return input unless try_result

          result =
            if value.negative?
              for_minus.map { |expr| expr.call(input) }.join
            else
              for_plus_and_zero.map { |expr| expr.call(input) }.join
            end

          result != '' ? result : input
        end
      end

      rule(for_plus: subtree(:for_plus), for_minus: subtree(:for_minus), for_zero: subtree(:for_zero)) do
        ->(input) do
          try_result, value = ::XlsFunction::Converters::NumberConverter.try_convert(input)
          return input unless try_result

          result =
            if value.negative?
              for_minus.map { |expr| expr.call(input) }.join
            elsif value.zero?
              for_zero.map { |expr| expr.call(input) }.join
            else
              for_plus.map { |expr| expr.call(input) }.join
            end

          result != '' ? result : input
        end
      end

      rule(for_plus: subtree(:for_plus), for_minus: subtree(:for_minus), for_zero: subtree(:for_zero), for_string: subtree(:for_string)) do
        ->(input) do
          try_result, value = ::XlsFunction::Converters::NumberConverter.try_convert(input)
          result =
            if try_result
              if value.negative?
                for_minus.map { |expr| expr.call(input) }.join
              elsif value.zero?
                for_zero.map { |expr| expr.call(input) }.join
              else
                for_plus.map { |expr| expr.call(input) }.join
              end
            else
              for_string.map { |expr| expr.call(input) }.join
            end

          result != '' ? result : input
        end
      end

      def apply(obj, context = nil)
        context ||= {}
        context[:caches] ||= {}
        context[:flags] ||= {}
        super(obj, context)
      end
    end
  end
end
