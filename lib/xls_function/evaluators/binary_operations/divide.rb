module XlsFunction
  module Evaluators
    module BinaryOperations
      class Divide < ::XlsFunction::Evaluators::BinaryOperationEvaluator
        operator_as '/'

        def eval
          return ::XlsFunction::ErrorValue.div0!(divide_by_zero) if right.zero?

          left / right
        end

        private

        def divide_by_zero
          message = error_message(:cannot_divide_by_zero)
          class_info(message)
        end
      end
    end
  end
end
