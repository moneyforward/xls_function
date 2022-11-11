module XlsFunction
  module Evaluators
    module ErrorDetector
      def self.included(klass)
        klass.class_eval do
          attr_reader :error_value
        end
      end

      def rescue_with(error_class)
        yield
      rescue error_class => e
        if XlsFunction.verbose
          XlsFunction.logger.write(e.inspect)
          XlsFunction.logger.write(e.backtrace)
        end
        ::XlsFunction::ErrorValue.value!(class_info(e.message))
      end

      def class_info(message = '')
        "#{class_name.upcase}:#{message}"
      end

      def class_name
        self.class.name&.split('::')&.last || 'Class'
      end
    end
  end
end
