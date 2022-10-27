module XlsFunction
  module Evaluators
    module Functions
      class Isnumber < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :isnumber

        define_arg :source

        def eval
          source.is_a?(Numeric)
        end
      end
    end
  end
end
