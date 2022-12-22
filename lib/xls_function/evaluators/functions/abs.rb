module XlsFunction
  module Evaluators
    module Functions
      class Abs < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :abs

        define_arg :number, type: :number

        def eval
          number.abs.to_d
        end
      end
    end
  end
end
