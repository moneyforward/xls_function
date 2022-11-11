module XlsFunction
  module Evaluators
    module Functions
      class Lower < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :lower

        define_arg :source

        def eval
          source.downcase
        end
      end
    end
  end
end
