module XlsFunction
  module Evaluators
    class FalseEvaluator
      include Evaluable

      # unused, but hold for future logging...
      attr_reader :source

      def initialize(source, context)
        @source = source
        @context = context
      end

      def eval
        false
      end
    end
  end
end
