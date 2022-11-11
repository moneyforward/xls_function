module XlsFunction
  module Evaluators
    module Functions
      class Int < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :int

        define_arg :number, type: :number

        def eval
          number.floor(0).to_d
        end
      end
    end
  end
end
