module XlsFunction
  module Evaluators
    module Functions
      class Unicode < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :unicode

        define_arg :source

        def eval
          s = source.to_s
          return if s.empty?

          s.encode(Encoding::UTF_8).ord
        end
      end
    end
  end
end
