module XlsFunction
  module Evaluators
    class NumberEvaluator
      include Evaluable

      attr_reader :source

      def initialize(source, context)
        @source = source
        @context = context
      end

      def eval
        source.to_s.to_d
      end
    end
  end
end
