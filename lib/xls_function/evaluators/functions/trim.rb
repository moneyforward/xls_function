module XlsFunction
  module Evaluators
    module Functions
      class Trim < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :trim

        define_arg :source

        def eval
          trimed = source.to_s.gsub(/(^[\s　]+)|([\s　]+$)/, '')
          trimed.gsub(/[\s　]+/) { |spaces| spaces[0] }
        end
      end
    end
  end
end
