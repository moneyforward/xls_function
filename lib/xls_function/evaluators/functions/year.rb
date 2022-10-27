module XlsFunction
  module Evaluators
    module Functions
      class Year < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :year

        define_arg :date_value, type: :date

        def eval
          date_value.year
        end
      end
    end
  end
end
