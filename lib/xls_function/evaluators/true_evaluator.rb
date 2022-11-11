module XlsFunction
  module Evaluators
    class TrueEvaluator
      include Evaluable

      # unused, but hold for future logging...
      attr_reader :source

      def initialize(source, context)
        @source = source
        @context = context
      end

      def eval
        true
      end
    end
  end
end
