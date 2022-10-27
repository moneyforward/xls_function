module XlsFunction
  module Evaluators
    module Functions
      class Substitute < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :substitute

        define_arg :source
        define_arg :search_for
        define_arg :replace_with
        define_arg :instance_num, default: 0

        def eval
          instance_num_i = instance_num.to_i
          return ::XlsFunction::ErrorValue.value!(instance_num_is_negative(instance_num_i)) if instance_num_i.negative?

          if replace_all?(instance_num_i)
            replace_all(source, search_for, replace_with)
          else
            replace(source, search_for, replace_with, instance_num_i)
          end
        end

        private

        def replace_all?(instance_num_i)
          instance_num_i.zero?
        end

        def replace_all(source, search_for, replace_with)
          source.gsub(search_for, replace_with)
        end

        def replace(source, search_for, replace_with, instance_num_i)
          source.gsub(search_for).with_index(1) { |s, i| i == instance_num_i ? replace_with : s }
        end

        def instance_num_is_negative(instance_num_i)
          message = error_message(:number_is_negative, label: 'instance_num', number: instance_num_i)
          class_info(message)
        end
      end
    end
  end
end
