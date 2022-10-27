module XlsFunction
  module TransformRules
    module FunctionCallTransform
      def self.included(klass)
        klass.class_eval do
          rule(identifier: simple(:identifier), arglist: subtree(:arglist)) do |context|
            func = ::XlsFunction::Evaluators::FunctionEvaluator.from_dictionary(context[:identifier].to_s.downcase.to_sym)
            raise ::XlsFunction::Transform::NotImplementedFunctionError, "unsupported function #{context[:identifier]}" unless func

            func.create(context)
          end
        end
      end
    end
  end
end
