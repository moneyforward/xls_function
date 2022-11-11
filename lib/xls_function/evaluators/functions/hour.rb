module XlsFunction
  module Evaluators
    module Functions
      class Hour < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :hour

        define_arg :time_value, type: :time

        def eval
          time_value.hour
        end
      end
    end
  end
end
