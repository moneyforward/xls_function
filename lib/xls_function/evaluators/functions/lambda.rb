module XlsFunction
  module Evaluators
    module Functions
      class Lambda < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :lambda

        def eval_arglist
          # Skip common argument evaluation and assignment
        end

        def eval
          # arguments at lambda
          # the last one is calculation
          calculation = arg_list.pop
          # returns as anonymous class
          klass = Class.new(Function)

          klass.define_singleton_method(:create) do |context|
            klass.new(context, calculation)
          end

          # define variant as argument
          arg_list.each do |variant|
            klass.define_arg variant.name.to_sym
          end

          klass
        end

        class Function < ::XlsFunction::Evaluators::FunctionEvaluator
          # use in lambda
          attr_reader :calculation

          def initialize(context, calculation)
            super(context)
            @calculation = calculation
          end

          def eval_arglist
            super
            return if error?

            # set to variant
            self.class.arg_definitions.each do |name, _default, _type|
              variant_context[name.to_s] = instance_variable_get("@#{name}")
            end
          end

          def eval
            # run with composed context
            calculation.evaluate(context)
          end
        end
      end
    end
  end
end
