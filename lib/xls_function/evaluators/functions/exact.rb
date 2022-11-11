module XlsFunction
  module Evaluators
    module Functions
      class Exact < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :exact

        define_arg :source_1
        define_arg :source_2

        def eval
          source_1 == source_2
        end
      end
    end
  end
end
