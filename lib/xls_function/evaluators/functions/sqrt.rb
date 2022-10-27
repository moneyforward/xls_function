module XlsFunction
  module Evaluators
    module Functions
      class Sqrt < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :sqrt

        define_arg :number, type: :number

        def eval
          return ErrorValue.num!(error_message(:number_is_negative, label: 'number', number: number)) if number.negative?

          Math.sqrt(number).to_d
        end
      end
    end
  end
end
