module XlsFunction
  module ParseRules
    module BinaryOperation
      def self.included(klass)
        klass.class_eval do
          rule(:power_operator) { str('^').as(:operator) >> space? }
          rule(:multiple_divide_operator) { match['*/'].as(:operator) >> space? }
          rule(:plus_minus_opeartor) { match['+-'].as(:operator) >> space? }
          rule(:concat_opeartor) { str('&').as(:operator) >> space? }
          rule(:comparison_operator) { (str('<>') | str('>=') | str('<=') | str('>') | str('<') | str('=')).as(:operator) >> space? }

          rule(:binary_operation) do
            infix_expression(
              preferred_binary_operation | single_expression,
              [power_operator, 5, :left],
              [multiple_divide_operator, 4, :left],
              [plus_minus_opeartor, 3, :left],
              [concat_opeartor, 2, :left],
              [comparison_operator, 1, :left]
            ) { |l, o, r| { left: l, operator: o[:operator], right: r } }
          end

          rule(:preferred_binary_operation) { lparen >> binary_operation >> rparen }
        end
      end
    end
  end
end
