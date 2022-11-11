module XlsFunction
  module Evaluators
    module Functions
      class Ifs < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :ifs

        def eval_arglist
          # Skip common argument evaluation and assignment for short-circuit
        end

        def eval
          # Return the first result expr is true
          arg_list.each_slice(2) do |expr, value|
            return value&.evaluate(context) if expr&.evaluate(context)
          end
        end
      end
    end
  end
end
