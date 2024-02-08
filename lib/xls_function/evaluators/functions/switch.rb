module XlsFunction
  module Evaluators
    module Functions
      class Switch < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :switch

        def eval_arglist
          # Skip common argument evaluation and assignment for short-circuit
        end

        def eval
          condition = arg_list.first.evaluate(context)

          arg_list[1..-1].each_slice(2) do |expr, value|
            return value&.evaluate(context) if expr&.evaluate(context) == condition

            return expr&.evaluate(context) if value&.evaluate(context).nil?
          end

          XlsFunction::ErrorValue.na
        end
      end
    end
  end
end
