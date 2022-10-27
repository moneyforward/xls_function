module XlsFunction
  module Evaluators
    module Functions
      class Round < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :round

        define_arg :number, type: :number
        define_arg :num_digits, type: :number

        def eval
          number.round(num_digits.to_i).to_d
        end
      end
    end
  end
end
