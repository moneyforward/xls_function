require 'xls_function/format_string/parse_rules/texts'
require 'xls_function/format_string/parse_rules/numbers'
require 'xls_function/format_string/parse_rules/dates'
require 'xls_function/format_string/parse_rules/times'

module XlsFunction
  module FormatString
    class Parser < Parslet::Parser
      include ::XlsFunction::FormatString::ParseRules::Texts
      include ::XlsFunction::FormatString::ParseRules::Numbers
      include ::XlsFunction::FormatString::ParseRules::Dates
      include ::XlsFunction::FormatString::ParseRules::Times

      rule(:patterns) { times | dates | numbers | texts }
      rule(:expression) { patterns.repeat }
      rule(:sep) { str(';') }
      rule(:expr_sep) { space.maybe >> sep >> space.maybe }
      rule(:expressions) do
        (expression.as(:for_plus) >> expr_sep >> expression.as(:for_minus) >> expr_sep >> expression.as(:for_zero) >> expr_sep >> expression.as(:for_string)) |
        (expression.as(:for_plus) >> expr_sep >> expression.as(:for_minus) >> expr_sep >> expression.as(:for_zero)) |
        (expression.as(:for_plus_and_zero) >> expr_sep >> expression.as(:for_minus)) |
        expression.as(:for_all)
      end
      root(:expressions)
    end
  end
end
