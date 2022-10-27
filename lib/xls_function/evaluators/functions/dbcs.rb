require 'nkf'

module XlsFunction
  module Evaluators
    module Functions
      class Dbcs < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :dbcs

        define_arg :source

        def eval
          NKF.nkf('-w -X --ic=UTF-8 --oc=UTF-8', source)
             .tr('A-Z0-9', 'Ａ-Ｚ０-９')
        end
      end
    end
  end
end
