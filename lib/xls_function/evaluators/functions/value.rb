module XlsFunction
  module Evaluators
    module Functions
      class Value < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :value

        define_arg :source

        def eval
          # Delete comma because ruby converts '1,000' to 1.
          return BigDecimal(source.delete(',')) if source.is_a?(String)
          return source.to_d if source.respond_to?(:to_d)

          ::XlsFunction::ErrorValue.value!(cannot_convert)
        rescue TypeError, ArgumentError
          ::XlsFunction::ErrorValue.value!(cannot_convert)
        end

        def cannot_convert
          message = error_message(:cannot_convert_to_number, source: source)
          class_info(message)
        end
      end
    end
  end
end
