module XlsFunction
  module FormatString
    module TransformRules
      module Dates
        def self.included(klass)
          klass.class_eval do
            rule(year: simple(:year)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:year],
                context[:caches]
              )
            end

            rule(month: simple(:month)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:month],
                context[:caches],
                &:month
              )
            end

            rule(day: simple(:day)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:day],
                context[:caches],
                &:day
              )
            end

            rule(weekday: simple(:weekday)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:weekday],
                context[:caches],
                &:weekday
              )
            end

            rule(wareki: simple(:wareki)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:wareki],
                context[:caches],
                flags: context[:flags],
                &:wareki
              )
            end

            rule(gengo: simple(:gengo)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:gengo],
                context[:caches],
                &:gengo
              )
            end

            rule(gengo_wareki: simple(:gengo_wareki)) do |context|
              gengo_func =
                ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                  'ggg',
                  context[:caches],
                  &:gengo
                ).method(:call)

              wareki_func =
                ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                  'ee',
                  context[:caches],
                  &:wareki
                ).method(:call)

              ->(input) do
                gengo_func.call(input) + wareki_func.call(input)
              end
            end

            rule(gannen: simple(:gannen)) do |context|
              context[:flags][:gannen] = true
              ->(_) { '' }
            end

            rule(date: subtree(:date)) do
              ->(input) { date.call(input) }
            end

            rule(texts: subtree(:texts), date: subtree(:date)) do
              ->(input) do
                "#{texts.map { |expr| expr.call(input) }.join}#{date.call(input)}"
              end
            end

            rule(dates: subtree(:dates)) do
              ->(input) { Array(dates).flatten.map { |expr| expr.call(input) }.join }
            end
          end
        end
      end
    end
  end
end
