module XlsFunction
  module Evaluators
    module Evaluable
      using ::XlsFunction::Extensions::HashExtension

      def self.included(klass)
        klass.class_eval do
          attr_reader :context
        end
      end

      def evaluate(runtime_context = nil)
        merge_context(runtime_context) do
          before_eval
          eval
        end
      end

      private

      def merge_context(runtime_context = nil)
        origin_context = context
        @context = runtime_context.deep_merge(context) if runtime_context && runtime_context != context

        yield
      ensure
        @context = origin_context
      end

      def before_eval; end

      def eval
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end
    end
  end
end
