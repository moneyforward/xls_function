module XlsFunction
  module Evaluators
    module Functions
      class Sign < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :sign

        define_arg :number, type: :number

        def eval
          if number.positive?
            1
          elsif number.negative?
            -1
          else
            0
          end
        end
      end
    end
  end
end
