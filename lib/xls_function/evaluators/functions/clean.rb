require 'nkf'

module XlsFunction
  module Evaluators
    module Functions
      class Clean < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :clean

        define_arg :source

        TARGET_CHARS = (0..31).map(&:chr).join
        # Remove nonprinting characters in the Unicode character set.
        TARGET_CHARS_UNI = [127, 129, 141, 143, 144, 157].map { |n| n.chr(Encoding::UTF_8) }.join

        def eval
          s = source.delete(TARGET_CHARS)
          s.delete!(TARGET_CHARS_UNI) || s
        end
      end
    end
  end
end
