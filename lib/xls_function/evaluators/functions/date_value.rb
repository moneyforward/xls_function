module XlsFunction
  module Evaluators
    module Functions
      class Datevalue < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :datevalue

        define_arg :date_value, type: :date

        using XlsFunction::Extensions::DateExtension

        def eval
          date_value.to_serial
        end
      end
    end
  end
end
