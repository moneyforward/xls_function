module XlsFunction
  module Evaluators
    module Functions
      class Text < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :text

        define_arg :value
        define_arg :format_text

        def eval
          converter = ::XlsFunction::FormatString.evaluate_converter(format_text, context)
          converter.call(value)
        end
      end
    end
  end
end
