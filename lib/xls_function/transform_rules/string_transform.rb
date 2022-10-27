module XlsFunction
  module TransformRules
    module StringTransform
      def self.included(klass)
        klass.class_eval do
          # empty string pattern
          rule(string: []) do
            ::XlsFunction::Evaluators::StringEvaluator.new('', {})
          end
          rule(string: simple(:string)) do |context|
            ::XlsFunction::Evaluators::StringEvaluator.new(context[:string], context)
          end
        end
      end
    end
  end
end
