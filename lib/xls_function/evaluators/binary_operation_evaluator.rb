module XlsFunction
  module Evaluators
    class BinaryOperationEvaluator < FunctionEvaluator
      define_arg :left
      define_arg :right

      class << self
        alias operator_as register_dictionary

        def create(left, right, context)
          new(context.merge(arglist: [left, right]))
        end
      end
    end
  end
end

Dir[File.expand_path('binary_operations', __dir__) << '/*.rb'].sort.each do |file|
  require file
end
