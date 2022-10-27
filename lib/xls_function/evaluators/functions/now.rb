module XlsFunction
  module Evaluators
    module Functions
      class Now < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :now

        using ::XlsFunction::Extensions::TimeExtension

        def eval
          now.to_serial
        end

        def now
          Time.now
        end
      end
    end
  end
end
