module XlsFunction
  module Evaluators
    module Functions
      class Code < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :code

        define_arg :source

        def eval
          s = source.to_s
          return if s.empty?

          s.ord
        end
      end
    end
  end
end
