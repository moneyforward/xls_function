module XlsFunction
  module Evaluators
    module BinaryOperations
      class Power < ::XlsFunction::Evaluators::BinaryOperationEvaluator
        operator_as '^'

        def eval
          left**right
        end
      end
    end
  end
end
