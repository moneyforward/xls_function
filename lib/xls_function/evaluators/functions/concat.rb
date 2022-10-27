module XlsFunction
  module Evaluators
    module Functions
      class Concat < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :concat

        MAX_ARGUMENTS_COUNT = 253
        MAX_ARGUMENTS_COUNT.times do |n|
          text_name = :"text#{n + 1}"
          define_arg text_name
        end

        def text_of(number)
          send(:"text#{number}")
        end

        def eval
          arr = Array.new(MAX_ARGUMENTS_COUNT) do |index|
            text_of(index + 1)
          end

          arr.compact.join
        end
      end
    end
  end
end
