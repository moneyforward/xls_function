require 'xls_function/evaluators/evaluable'
require 'xls_function/evaluators/arguments_definable'
require 'xls_function/evaluators/error_detector'
require 'xls_function/evaluators/class_dictionary'

require 'xls_function/evaluators/string_evaluator'
require 'xls_function/evaluators/variant_evaluator'
require 'xls_function/evaluators/number_evaluator'
require 'xls_function/evaluators/true_evaluator'
require 'xls_function/evaluators/false_evaluator'
require 'xls_function/evaluators/function_evaluator'
require 'xls_function/evaluators/binary_operation_evaluator'

require 'xls_function/transform_rules/string_transform'
require 'xls_function/transform_rules/variant_transform'
require 'xls_function/transform_rules/number_transform'
require 'xls_function/transform_rules/boolean_transform'
require 'xls_function/transform_rules/binary_operation_transform'
require 'xls_function/transform_rules/function_call_transform'

require 'xls_function/user_defined_function_factory'

module XlsFunction
  class Transform < Parslet::Transform
    include ::XlsFunction::TransformRules::StringTransform
    include ::XlsFunction::TransformRules::VariantTransform
    include ::XlsFunction::TransformRules::NumberTransform
    include ::XlsFunction::TransformRules::BooleanTransform
    include ::XlsFunction::TransformRules::FunctionCallTransform
    include ::XlsFunction::TransformRules::BinaryOperationTransform

    def apply(obj, context = {})
      context ||= {}
      context[:variants] ||= {}
      context[:caches] ||= {}
      super(obj, context)
    end

    class NotImplementedFunctionError < XlsFunction::EvaluationError
    end

    class VariantUndefinedError < XlsFunction::EvaluationError
    end

    class << self
      private

      def add_function(key, block_or_source, description: nil)
        raise 'add_function: missing key' if key.nil?

        fn = XlsFunction::UserDefinedFunctionFactory.create(block_or_source)

        fn.description(description)
        XlsFunction.class_dictionary[key] = fn
      end
    end
  end
end
