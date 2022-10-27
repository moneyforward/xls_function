module XlsFunction
  module Evaluators
    module Functions
      class Left < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :left

        define_arg :source
        define_arg :length

        def eval
          source[0, length]
        end
      end
    end
  end
end
