module XlsFunction
  module Evaluators
    module Functions
      class Replace < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :replace

        define_arg :source
        define_arg :start_index
        define_arg :length
        define_arg :replace_string

        def eval
          source[start_index - 1, length] = replace_string
          source
        end
      end
    end
  end
end
