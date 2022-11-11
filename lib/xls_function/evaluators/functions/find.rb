module XlsFunction
  module Evaluators
    module Functions
      class Find < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :find

        define_arg :find_text
        define_arg :within_text
        define_arg :start, default: 1

        def eval
          index = within_text.index(find_text, start - 1)

          if index
            index + 1
          else
            ::XlsFunction::ErrorValue.value!(missing_target)
          end
        end

        def missing_target
          message = error_message(:missing_target, source: within_text, target: find_text)
          class_info(message)
        end
      end
    end
  end
end
