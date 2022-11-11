module XlsFunction
  module FormatString
    module TransformRules
      module Times
        def self.included(klass)
          klass.class_eval do
            rule(hour: simple(:hour)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:hour],
                context[:caches],
                flags: context[:flags],
                &:hour
              )
            end

            rule(hour_elapsed: simple(:hour_elapsed)) do |context|
              ::XlsFunction::FormatString::Evaluators::ElapsedTimeEvaluator.new(
                context[:caches],
                half: context[:hour_elapsed] == '[h]',
                &:hour
              )
            end

            rule(minute: simple(:minute)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:minute],
                context[:caches],
                minute_mode: true,
                &:minute
              )
            end

            rule(minute_elapsed: simple(:minute_elapsed)) do |context|
              ::XlsFunction::FormatString::Evaluators::ElapsedTimeEvaluator.new(
                context[:caches],
                half: context[:minute_elapsed] == '[m]',
                &:minute
              )
            end

            rule(second: simple(:second)) do |context|
              ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                context[:second],
                context[:caches],
                &:second
              )
            end

            rule(second: simple(:second), millisecond: simple(:millisecond)) do |context|
              ->(input) do
                second_func = ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                  context[:second],
                  context[:caches],
                  &:second
                )
                millisecond_func = ::XlsFunction::FormatString::Evaluators::TimeEvaluator.new(
                  context[:millisecond],
                  context[:caches]
                )
                "#{second_func.call(input)}.#{millisecond_func.call(input)}"
              end
            end

            rule(second_elapsed: simple(:second_elapsed)) do |context|
              ::XlsFunction::FormatString::Evaluators::ElapsedTimeEvaluator.new(
                context[:caches],
                half: context[:second_elapsed] == '[s]',
                &:second
              )
            end

            rule(ampm: simple(:ampm)) do |context|
              context[:flags][:ampm] = true
              ->(input) do
                time = ::XlsFunction::Converters::TimeConverter.convert_with_cache(input, context[:caches])
                am, pm = context[:ampm].to_s.split('/')
                time.hour <= 11 ? am : pm
              end
            end

            rule(time: subtree(:time)) { time }

            rule(texts: subtree(:texts), time: subtree(:time)) do
              ->(input) do
                "#{texts.map { |expr| expr.call(input) }.join}#{time.call(input)}"
              end
            end

            rule(times: subtree(:time)) do
              ->(input) { Array(time).flatten.map { |expr| expr.call(input) }.join }
            end
          end
        end
      end
    end
  end
end
