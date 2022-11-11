module XlsFunction
  module Evaluators
    module Functions
      class Day < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :day

        define_arg :date_value, type: :date

        def eval
          date_value.day
        end
      end
    end
  end
end
