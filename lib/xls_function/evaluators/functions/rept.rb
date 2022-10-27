module XlsFunction
  module Evaluators
    module Functions
      class Rept < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :rept

        define_arg :source
        define_arg :number_times, type: :number

        def eval
          number_times_i = number_times.to_i
          return ::XlsFunction::ErrorValue.value!(number_times_is_negative) if number_times_i.negative?
          return '' if number_times_i.zero?

          source * number_times_i
        end

        def number_times_is_negative
          message = error_message(:number_is_negative, label: 'number_times', number: number_times)
          class_info(message)
        end
      end
    end
  end
end
