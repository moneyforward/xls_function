module XlsFunction
  module Evaluators
    module Functions
      class POWER < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :power

        define_arg :number, type: :number
        define_arg :power, type: :number

        def eval
          number**power
        end
      end
    end
  end
end
