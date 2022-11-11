module XlsFunction
  module Evaluators
    module Functions
      class RoundUp < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :roundup

        define_arg :number, type: :number
        define_arg :num_digits, type: :number

        def eval
          number.round(num_digits.to_i, BigDecimal::ROUND_UP).to_d
        end
      end
    end
  end
end
