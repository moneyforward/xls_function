module XlsFunction
  module Evaluators
    module Functions
      class Fixed < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :fixed

        define_arg :number
        define_arg :digits, default: 2
        define_arg :no_format, default: false
        define_arg :delimiter, default: ','
        define_arg :separator, default: '.'

        DELIMITER_REGEX = /(\d)(?=(\d\d\d)+(?!\d))/.freeze

        def eval
          rounded = round

          if no_format
            rounded.to_s
          else
            delimit(rounded)
          end
        end

        def round
          n = number.round(digits)
          if digits.positive?
            n.to_f
          else
            n.to_i
          end
        end

        def delimit(num)
          i, f = num.to_s.split('.')
          i.gsub!(DELIMITER_REGEX) do |digit|
            "#{digit}#{delimiter}"
          end

          [i, f].compact
                .join(separator)
        end
      end
    end
  end
end
