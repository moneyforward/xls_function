module XlsFunction
  module FormatString
    module ParseRules
      module Texts
        def self.included(klass)
          klass.class_eval do
            rule(:space) { match('\s').repeat(1) }

            rule(:default) { str('G/標準').as(:placeholder) }
            rule(:placeholder) { str('@').as(:placeholder) }

            rule(:escaped_string) { str('!') >> match('.').as(:string) }

            rule(:string) do
              (expr_sep | time | ampm | date | number).absent? >> any.as(:string)
            end

            rule(:text) { (escaped_string | placeholder | default | string).as(:text) }
            rule(:texts) { text.repeat(1).as(:texts) }
          end
        end
      end
    end
  end
end
