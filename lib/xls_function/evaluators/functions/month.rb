module XlsFunction
  module Evaluators
    module Functions
      class Month < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :month

        define_arg :date_value, type: :date

        def eval
          date_value.month
        end
      end
    end
  end
end
