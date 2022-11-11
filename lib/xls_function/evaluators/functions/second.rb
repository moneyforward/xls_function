module XlsFunction
  module Evaluators
    module Functions
      class Second < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :second

        define_arg :time_value, type: :time

        def eval
          time_value.sec
        end
      end
    end
  end
end
