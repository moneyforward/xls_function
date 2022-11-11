module XlsFunction
  module Evaluators
    class StringEvaluator
      include Evaluable

      attr_reader :source

      def initialize(source, context)
        @source = source
        @context = context
      end

      def eval
        source.to_s
      end
    end
  end
end
