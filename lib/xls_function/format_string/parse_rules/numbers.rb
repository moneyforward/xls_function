module XlsFunction
  module FormatString
    module ParseRules
      module Numbers
        def self.included(klass)
          klass.class_eval do
            rule(:digit_s) { str('#').as(:digit_s) }
            rule(:digit_z) { str('0').as(:digit_z) }
            rule(:digit_q) { str('?').as(:digit_q) }

            rule(:number) { (digit_s | digit_z | digit_q).as(:number) }

            rule(:suffixable) do
              str(',').as(:string).repeat(1, 2) |
                str('%').as(:string) |
                str('.').as(:string)
            end

            rule(:numbers) do
              (
                (
                  number >> (texts.maybe >> number).repeat
                ) >> suffixable.maybe
              ).as(:numbers)
            end
          end
        end
      end
    end
  end
end
