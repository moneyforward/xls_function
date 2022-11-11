module XlsFunction
  module Evaluators
    module Functions
      class Let < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :let

        def eval_arglist
          # Skip common argument evaluation and assignment
        end

        def eval
          # last arg is calculation
          calculation = arg_list.pop
          # set evaluated result to variant context
          arg_list.each_slice(2) do |variant, expr|
            variant_context[variant.name] = expr&.evaluate(context)
          end

          calculation.evaluate(context)
        end
      end
    end
  end
end
