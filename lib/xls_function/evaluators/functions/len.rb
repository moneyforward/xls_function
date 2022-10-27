module XlsFunction
  module Evaluators
    module Functions
      class Len < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :len

        define_arg :source

        def eval
          source.length
        end
      end
    end
  end
end
