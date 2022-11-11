module XlsFunction
  module ParseRules
    module Common
      def self.included(klass)
        klass.class_eval do
          rule(:space) { match('\s').repeat(1) }
          rule(:space?) { space.maybe }

          rule(:comma) { str(',') >> space? }

          rule(:negative_sign) { str('-') }
          rule(:number) { (negative_sign.maybe >> match['0-9\.'].repeat(1)).as(:number) >> space? }

          rule(:true_expr) { (match['Tt'] >> match['Rr'] >> match['Uu'] >> match['Ee']).as(:true_expr) }
          rule(:false_expr) { (match['Ff'] >> match['Aa'] >> match['Ll'] >> match['Ss'] >> match['Ee']).as(:false_expr) }
          rule(:boolean) { true_expr | false_expr }

          rule(:string) { str('"') >> match('[^"]').repeat.as(:string) >> str('"') >> space? }
          rule(:variant) { match['a-zA-Z_'].repeat(1).as(:variant) >> space? }

          rule(:lparen) { str('(') >> space? }
          rule(:rparen) { str(')') >> space? }

          rule(:identifier) { match['a-zA-Z'].repeat(1) }

          rule(:arglist) { expression >> (comma >> expression).repeat }
          rule(:function_call) { identifier.as(:identifier) >> lparen >> arglist.maybe.as(:arglist) >> rparen >> space? }

          rule(:single_expression) { function_call | number | boolean | string | variant }
        end
      end
    end
  end
end
