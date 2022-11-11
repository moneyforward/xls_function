module XlsFunction
  module Evaluators
    module Functions
      class Unichar < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :unichar

        define_arg :number

        def eval
          return '' unless number.respond_to?(:to_i)

          number.to_i.chr(Encoding::UTF_8)
        rescue RangeError => e
          e.message
        end
      end
    end
  end
end
