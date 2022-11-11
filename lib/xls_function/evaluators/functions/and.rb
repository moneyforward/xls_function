module XlsFunction
  module Evaluators
    module Functions
      class And < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :and

        def eval_arglist
          # Skip common argument evaluation and assignment for short-circuit
        end

        def eval
          arg_list.each do |arg|
            return false unless arg.evaluate(context)
          end

          true
        end
      end
    end
  end
end
