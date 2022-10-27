module XlsFunction
  module Evaluators
    module Functions
      class Mid < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :mid

        define_arg :source
        define_arg :start
        define_arg :length

        def eval
          source[safe_start, length]
        end

        def safe_start
          return 0 unless start.positive?

          start - 1
        end
      end
    end
  end
end
