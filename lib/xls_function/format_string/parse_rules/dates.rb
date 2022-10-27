module XlsFunction
  module FormatString
    module ParseRules
      module Dates
        def self.included(klass)
          klass.class_eval do
            rule(:year_half) { str('yy').as(:year) }
            rule(:year) { str('yyyy').as(:year) }
            rule(:month_half) { str('m').as(:month) }
            rule(:month) { str('mm').as(:month) }
            rule(:month_3) { str('mmm').as(:month) }
            rule(:month_4) { str('mmmm').as(:month) }
            rule(:month_5) { str('mmmmm').as(:month) }
            rule(:day_half) { str('d').as(:day) }
            rule(:day) { str('dd').as(:day) }
            rule(:weekday) { str('aaa').as(:weekday) }
            rule(:weekday_4) { str('aaaa').as(:weekday) }
            rule(:weekday_d) { str('ddd').as(:weekday) }
            rule(:weekday_d_4) { str('dddd').as(:weekday) }

            rule(:wareki_year_half) { str('e').as(:wareki) }
            rule(:wareki_year) { (str('ee') | str('r')).as(:wareki) }
            rule(:gengo) { str('g').as(:gengo) }
            rule(:gengo_2) { (str('gg')).as(:gengo) }
            rule(:gengo_3) { str('ggg').as(:gengo) }

            rule(:gengo_wareki) { (str('gggee') | str('rr')).as(:gengo_wareki) }
            rule(:gannen) { str('[$-ja-JP-x-gannen]').as(:gannen) }

            rule(:date) do
              (
                year | year_half |
                month_5 | month_4 | month_3 | month | month_half |
                day | day_half |
                weekday_d_4 | weekday_d | weekday_4 | weekday |
                gengo_wareki |
                wareki_year | wareki_year_half |
                gengo_3 | gengo_2 | gengo |
                gannen
              ).as(:date)
            end

            rule(:dates) do
              (
                date >> (texts.maybe >> date).repeat
              ).as(:dates)
            end
          end
        end
      end
    end
  end
end
