module XlsFunction
  module Evaluators
    module Functions
      class Iserror < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :iserror

        define_arg :value

        def eval
          value.is_a?(::XlsFunction::ErrorValue)
        end

        # return false to avoid skip eval
        def error?
          false
        end
      end
    end
  end
end
