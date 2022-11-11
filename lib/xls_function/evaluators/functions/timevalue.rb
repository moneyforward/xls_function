module XlsFunction
  module Evaluators
    module Functions
      class Timevalue < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :timevalue

        define_arg :time_value, type: :time

        using ::XlsFunction::Extensions::TimeExtension

        def eval
          time_value.to_serial(except_date: true)
        end
      end
    end
  end
end
