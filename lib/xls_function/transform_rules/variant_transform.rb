module XlsFunction
  module TransformRules
    module VariantTransform
      def self.included(klass)
        klass.class_eval do
          rule(variant: simple(:name)) do |context|
            ::XlsFunction::Evaluators::VariantEvaluator.new(context[:name], context)
          end
        end
      end
    end
  end
end
