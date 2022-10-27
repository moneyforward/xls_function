require 'xls_function/parse_rules/common'
require 'xls_function/parse_rules/binary_operation'

module XlsFunction
  class Parser < Parslet::Parser
    include ::XlsFunction::ParseRules::Common
    include ::XlsFunction::ParseRules::BinaryOperation

    rule(:expression) { binary_operation | single_expression }
    root(:expression)
  end
end
