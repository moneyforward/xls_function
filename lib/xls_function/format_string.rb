# Parse `format_text` of TEXT function.
# Some specifications are not supported.
# - Exponent, Fraction
# - Convert Chinese characters number
# - Monospace conversion with underscore
# - Cell width filling with asterisks
# - Buddhist calendar
# - Islamic calendar
# - Text coloring

require 'xls_function/format_string/parser'
require 'xls_function/format_string/transform'

module XlsFunction
  module FormatString
    class << self
      def evaluate_converter(format_string, context)
        parser = XlsFunction::FormatString::Parser.new
        transform = XlsFunction::FormatString::Transform.new
        transform.apply(parser.parse(format_string), context)
      end
    end
  end
end
