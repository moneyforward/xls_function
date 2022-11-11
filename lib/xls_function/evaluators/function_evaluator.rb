module XlsFunction
  module Evaluators
    class FunctionEvaluator
      include Evaluable
      include ArgumentsDefinable
      include ErrorDetector
      include ClassDictionary

      using ::XlsFunction::Extensions::ArrayExtension
      using ::XlsFunction::Extensions::HashExtension

      def initialize(context)
        @context = context
      end

      def arg_list
        @arg_list ||= Array(context[:arglist])
      end

      # @override
      def evaluate(runtime_context = nil)
        rescue_with StandardError do
          merge_context(runtime_context) do
            before_eval
            # Don't evaluate when returns error
            return error_value if error?

            eval_or_map_eval
          end
        end
      end

      def before_eval
        eval_arglist
      end

      def eval_arglist
        definitions = self.class.arg_definitions
        return if definitions.empty?

        definitions.zip(arg_list).each do |(name, default, type), arg|
          value = arg ? evaluate_or_self(arg) : default
          value = convert_to(value, type)
          instance_variable_set(:"@#{name}", value)
          detect_error(value)
          break if error?
        end
      end

      def evaluate_or_self(arg)
        arg.respond_to?(:evaluate) ? arg.evaluate(context) : arg
      end

      def convert_to(value, type)
        return value unless type

        succeed, result = XlsFunction::Converter.try_convert_to(type, value)
        succeed ? result : XlsFunction::ErrorValue.value!(class_info(result))
      end

      def eval_or_map_eval
        args = defined_args
        if args.any? { |arg| arg.is_a?(Array) }
          map_eval(args)
        else
          eval
        end
      end

      def map_eval(args)
        arg_array = args.map { |x| Array(x) }
                        .then { |xs| xs.length == 1 ? xs : xs[0].product(*xs[1..]) }
        return XlsFunction::ErrorValue.na(class_info(error_message(:invalid_value_for_function))) if arg_array.max_depth > 2

        arg_array.map do |arg|
          to_proc.call(*arg) # Executes each created arguments as argument of self.
        end
      end

      def detect_error(value)
        return unless value.is_a?(XlsFunction::ErrorValue)

        @error_value = value
      end

      def error?
        !!error_value
      end

      def variant_context
        context[:variants]
      end

      def to_proc
        self.class.to_proc(context)
      end

      def error_message(key, **placeholders)
        I18n.t("xls_function.errors.#{key}", **placeholders)
      end

      class << self
        alias function_as register_dictionary

        def create(context)
          new(context)
        end

        def to_h
          {
            class: name,
            proc: to_proc,
            description: translated_description
          }
        end

        def translated_description
          I18n.t("xls_function.descriptions.#{@register_key}", default: @description)
        end

        def to_proc(context = {})
          proc do |*arglist|
            new(arglist, context).evaluate
          end
        end
      end
    end
  end
end

Dir[File.expand_path('functions', __dir__) << '/*.rb'].sort.each do |file|
  require file
end
