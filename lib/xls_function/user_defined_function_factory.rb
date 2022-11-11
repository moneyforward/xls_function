module XlsFunction
  module UserDefinedFunctionFactory
    class << self
      def create(block_or_source)
        if block_or_source.respond_to?(:call)
          create_from_proc(block_or_source)
        else
          create_from_source(block_or_source.to_s)
        end
      end

      private

      def create_from_proc(block)
        klass = Class.new(ProcFunction)

        klass.define_singleton_method(:create) do |context|
          klass.new(context, block)
        end

        klass
      end

      def create_from_source(source)
        raise 'UserDefinedFunction: missing source' if source.nil?

        fn = XlsFunction.evaluate(source)
        raise 'UserDefinedFunction: use LAMBDA to add your function' unless fn < XlsFunction::Evaluators::Functions::Lambda::Function

        fn
      end
    end

    class ProcFunction < ::XlsFunction::Evaluators::FunctionEvaluator
      attr_reader :custom_proc, :evaled_arglist

      def initialize(context, custom_proc)
        super(context)
        @custom_proc = custom_proc
      end

      # @override
      def eval_arglist
        # There is no argument definition, so it evaluates as it is passed.
        @evaled_arglist = arg_list.map do |arg|
          value = evaluate_or_self(arg)
          detect_error(value)
          break if error?

          value
        end
      end

      def eval
        custom_proc.call(*evaled_arglist)
      end
    end
  end
end
