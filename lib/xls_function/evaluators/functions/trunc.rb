module XlsFunction
  module Evaluators
    module Functions
      class Trunc < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :trunc

        define_arg :number, type: :number
        define_arg :num_digits, type: :number, default: 0

        def eval
          number.truncate(num_digits.to_i).to_d
        end
      end
    end
  end
end
