module XlsFunction
  module Evaluators
    module Functions
      class Right < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :right

        define_arg :source
        define_arg :length

        def eval
          source[-length..-1]
        end
      end
    end
  end
end
