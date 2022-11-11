module XlsFunction
  module Evaluators
    module Functions
      class Proper < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :proper

        define_arg :source

        def eval
          source.split(/([[:digit:][:blank:][:punct:]]+)/)
                .map(&:capitalize)
                .join
        end
      end
    end
  end
end
