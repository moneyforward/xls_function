module XlsFunction
  module Evaluators
    module Functions
      class Today < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :today

        using ::XlsFunction::Extensions::DateExtension

        def eval
          today.to_serial
        end

        def today
          Date.today
        end
      end
    end
  end
end
