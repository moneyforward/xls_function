module XlsFunction
  module FormatString
    module ParseRules
      module Times
        def self.included(klass)
          klass.class_eval do
            rule(:hour_half) { str('h').as(:hour) }
            rule(:hour) { str('hh').as(:hour) }
            rule(:minute_half) { str('m').as(:minute) }
            rule(:minute) { str('mm').as(:minute) }
            rule(:second_half) { str('s').as(:second) }
            rule(:second) { str('ss').as(:second) }

            # elapsed time expressions
            rule(:hour_half_elapsed) { str('[h]').as(:hour_elapsed) }
            rule(:hour_elapsed) { str('[hh]').as(:hour_elapsed) }
            rule(:minute_half_elapsed) { str('[m]').as(:minute_elapsed) }
            rule(:minute_elapsed) { str('[mm]').as(:minute_elapsed) }
            rule(:second_half_elapsed) { str('[s]').as(:second_elapsed) }
            rule(:second_elapsed) { str('[ss]').as(:second_elapsed) }

            rule(:millisecond) { (str('.000') | str('.00') | str('.0')).as(:millisecond) }

            rule(:ampm) do
              (str('AM/PM') | str('am/pm') | str('A/P') | str('a/p')).as(:ampm)
            end

            rule(:hour_expression) { (hour_elapsed | hour_half_elapsed | hour | hour_half).capture(:hour_expr) }
            rule(:minute_expression_core) { minute | minute_half }
            # only mm after hh | before ss regarded as minutes.
            # if hh captured or ss appears later, mm is minute expression.
            rule(:minute_expression) do
              dynamic do |_source, context|
                minute_expression_core if context.captures[:hour_expr]
              rescue Parslet::Scope::NotFound
                minute_expression_core >> (texts.maybe >> second_expression).present?
              end
            end
            rule(:second_expression) { (second_elapsed | second_half_elapsed | second | second_half) >> millisecond.maybe }

            rule(:time) do
              hour_expression | minute_elapsed | minute_half_elapsed | minute_expression | second_expression
            end

            rule(:times) do
              (
                time.as(:time) >> (texts.maybe >> time.as(:time)).repeat >> texts.maybe >> ampm.maybe
              ).as(:times)
            end
          end
        end
      end
    end
  end
end
