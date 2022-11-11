module XlsFunction
  module Evaluators
    module Functions
      class Char < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :char

        define_arg :number

        def eval
          return '' unless number.respond_to?(:to_i)

          number.to_i.chr
        rescue RangeError => e
          e.message
        end
      end
    end
  end
end
