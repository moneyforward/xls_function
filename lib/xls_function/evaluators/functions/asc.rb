require 'nkf'

module XlsFunction
  module Evaluators
    module Functions
      class Asc < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :asc

        define_arg :source

        def eval
          NKF.nkf('-w -Z1 -Z4 -x --ic=UTF-8 --oc=UTF-8', source)
        end
      end
    end
  end
end
