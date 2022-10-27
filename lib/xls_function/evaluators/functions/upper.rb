module XlsFunction
  module Evaluators
    module Functions
      class Upper < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :upper

        define_arg :source

        def eval
          source.upcase
        end
      end
    end
  end
end
