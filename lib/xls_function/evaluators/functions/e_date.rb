module XlsFunction
  module Evaluators
    module Functions
      class EDate < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :edate

        define_arg :date_value, type: :date
        define_arg :month, type: :number

        using XlsFunction::Extensions::DateExtension

        def eval
          new_date = date_value >> month.to_i
          new_date.to_serial
        end
      end
    end
  end
end
