module XlsFunction
  module Evaluators
    module Functions
      class RoundDown < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :rounddown

        define_arg :number, type: :number
        define_arg :num_digits, type: :number

        def eval
          number.truncate(num_digits.to_i).to_d
        end
      end
    end
  end
end
