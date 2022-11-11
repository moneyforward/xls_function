module XlsFunction
  module Evaluators
    module Functions
      class Minute < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :minute

        define_arg :time_value, type: :time

        def eval
          time_value.min
        end
      end
    end
  end
end
