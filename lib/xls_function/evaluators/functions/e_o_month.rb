module XlsFunction
  module Evaluators
    module Functions
      class EOMonth < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :eomonth

        define_arg :date_value, type: :date
        define_arg :month, type: :number

        using XlsFunction::Extensions::DateExtension

        def eval
          new_date = date_value >> month.to_i
          last_date_of_month = Date.new(new_date.year, new_date.month, -1)
          last_date_of_month.to_serial
        end
      end
    end
  end
end
