module XlsFunction
  module TransformRules
    module BinaryOperationTransform
      def self.included(klass)
        klass.class_eval do
          rule(left: subtree(:left), operator: simple(:operator), right: subtree(:right)) do |context|
            ope = ::XlsFunction::Evaluators::BinaryOperationEvaluator.from_dictionary(context[:operator].to_s)
            raise ::XlsFunction::Transform::NotImplementedFunctionError, "not supported operator #{context[:operator]}" unless ope

            ope.create(context[:left], context[:right], context)
          end
        end
      end
    end
  end
end
