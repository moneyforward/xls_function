module XlsFunction
  module FormatString
    module Evaluators
      class ElapsedTimeEvaluator
        attr_reader :cache, :half, :parse_proc

        using ::XlsFunction::Extensions::DateExtension
        using ::XlsFunction::Extensions::TimeExtension

        def initialize(cache, half: true, &parse_proc)
          @cache = cache
          @half = half
          @parse_proc = parse_proc
        end

        def call(input)
          time = ::XlsFunction::Converters::TimeConverter.convert_with_cache(input, cache)

          result = parse_proc.call(self, time).to_i.to_s
          half ? result : result.rjust(2, '0')
        end

        def hour(time)
          elapsed_days = days_from_origin(time)
          elapsed_days * 24 + time.hour
        end

        def minute(time)
          hour(time) * 60 + time.min
        end

        def second(time)
          minute(time) * 60 + time.sec
        end

        def days_from_origin(time)
          time.to_date.to_serial
        end
      end
    end
  end
end
