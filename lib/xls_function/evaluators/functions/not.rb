module XlsFunction
  module Evaluators
    module Functions
      class Not < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :not

        define_arg :logical

        def eval
          !logical
        end
      end
    end
  end
end
