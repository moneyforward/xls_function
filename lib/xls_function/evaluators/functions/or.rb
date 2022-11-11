module XlsFunction
  module Evaluators
    module Functions
      class Or < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :or

        def eval_arglist
          # Skip common argument evaluation and assignment for short-circuit
        end

        def eval
          arg_list.each do |arg|
            return true if arg.evaluate(context)
          end

          false
        end
      end
    end
  end
end
