module XlsFunction
  module Evaluators
    module ArgumentsDefinable
      def self.included(klass)
        klass.class_eval do
          class << self
            def arg_definitions
              @arg_definitions || []
            end

            def inherited(subclass)
              super
              subclass.instance_variable_set(:@arg_definitions, arg_definitions.dup)
            end
          end
        end

        klass.extend(ClassMethods)
      end

      private

      def defined_args
        self.class.arg_definitions.map do |name, _default, _type|
          instance_variable_get("@#{name}")
        end
      end

      module ClassMethods
        def define_arg(name, default: nil, type: nil)
          @arg_definitions ||= []

          @arg_definitions << [name, default, type]
          attr_reader(name)
        end
      end
    end
  end
end
