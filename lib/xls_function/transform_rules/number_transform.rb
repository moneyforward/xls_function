module XlsFunction
  module TransformRules
    module NumberTransform
      def self.included(klass)
        klass.class_eval do
          rule(number: simple(:number)) { |context| ::XlsFunction::Evaluators::NumberEvaluator.new(context[:number], context) }
        end
      end
    end
  end
end
