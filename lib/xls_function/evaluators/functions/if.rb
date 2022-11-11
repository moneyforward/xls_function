module XlsFunction
  module Evaluators
    module Functions
      class If < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :if

        define_arg :condition
        define_arg :if_true
        define_arg :if_false

        def eval_arglist
          # Skip common argument evaluation and assignment for short-circuit
          @condition = arg_list[0]
          @if_true = arg_list[1]
          @if_false = arg_list[2]
        end

        def eval
          condition.evaluate(context) ? if_true.evaluate(context) : if_false.evaluate(context)
        end
      end
    end
  end
end
