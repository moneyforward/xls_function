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
            ex_value = expr&.evaluate(context)
            in_value = value&.evaluate(context)

            return in_value if ex_value == condition

            return ex_value if in_value.nil?
          end

          XlsFunction::ErrorValue.na(class_info(error_message(:missing_value_for_function)))
        end
      end
    end
  end
end
