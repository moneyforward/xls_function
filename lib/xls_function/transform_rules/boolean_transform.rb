module XlsFunction
  module TransformRules
    module BooleanTransform
      def self.included(klass)
        klass.class_eval do
          rule(true_expr: simple(:value)) { |context| ::XlsFunction::Evaluators::TrueEvaluator.new(context[:value], context) }
          rule(false_expr: simple(:value)) { |context| ::XlsFunction::Evaluators::FalseEvaluator.new(context[:value], context) }
        end
      end
    end
  end
end
