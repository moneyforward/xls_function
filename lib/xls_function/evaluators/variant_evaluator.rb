module XlsFunction
  module Evaluators
    class VariantEvaluator
      include Evaluable

      attr_reader :name

      def initialize(name, context)
        @name = name.to_s
        @context = context
      end

      def variant_context
        context[:variants]
      end

      def eval
        raise ::XlsFunction::Transform::VariantUndefinedError, "name: `#{name}` is undefined" unless variant_context.key?(name)

        variant_context[name]
      end
    end
  end
end
