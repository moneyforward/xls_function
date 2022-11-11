require 'xls_function/version'
require 'parslet'
require 'wareki'

require 'bigdecimal'
require 'bigdecimal/util'
require 'date'
require 'time'

require 'xls_function/i18n'
require 'xls_function/error'
require 'xls_function/default_logger'
require 'xls_function/class_dictionary'

require 'xls_function/converter'

require 'xls_function/extensions/hash_extension'
require 'xls_function/extensions/array_extension'
require 'xls_function/extensions/big_decimal_extension'
require 'xls_function/extensions/date_extension'
require 'xls_function/extensions/time_extension'

require 'xls_function/format_string'
require 'xls_function/parser'
require 'xls_function/transform'

module XlsFunction
  class Error < StandardError; end

  class << self
    def evaluate(source, **context)
      parsed = parser.parse(source.to_s.strip)
      transformed = transform.apply(parsed, context)
      transformed.evaluate
    end

    def parser
      return @parser_factory.call if @parser_factory

      XlsFunction::Parser.new
    end

    def use_parser_factory(&block)
      @parser_factory = block
    end

    def transform
      return @transform_factory.call if @transform_factory

      XlsFunction::Transform.new
    end

    def use_transform_factory(&block)
      @transform_factory = block
    end

    attr_accessor :verbose

    def logger
      @logger ||= XlsFunction::DefaultLogger.new
    end

    def logger=(obj)
      raise 'Logger must respond_to :write' unless obj.respond_to?(:write)

      @logger = obj
    end

    def locale=(value)
      I18n.locale = value
    end

    def current_locale
      I18n.locale
    end

    def functions
      dictionaries = class_dictionary.reject { |_, v| v < XlsFunction::Evaluators::BinaryOperationEvaluator }
      dictionaries.to_h { |identifier, klass| [identifier.to_s.upcase, klass.to_h] }
    end
  end
end
