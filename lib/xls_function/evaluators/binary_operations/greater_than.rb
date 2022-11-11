module XlsFunction
  module Evaluators
    module BinaryOperations
      class GreaterThan < ::XlsFunction::Evaluators::BinaryOperationEvaluator
        operator_as '>'

        def eval
          left > right
        end
      end
    end
  end
end
