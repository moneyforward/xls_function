module XlsFunction
  module FormatString
    module Evaluators
      class TimeEvaluator
        attr_reader :source, :cache, :minute_mode, :flags, :after_effect

        def initialize(source, cache, minute_mode: false, flags: {}, &after_effect)
          @source = source.to_s
          @cache = cache
          @minute_mode = minute_mode
          @flags = flags
          @after_effect = after_effect
        end

        def call(input)
          time = ::XlsFunction::Converters::TimeConverter.convert_with_cache(input, cache)
          format = convert_format
          result = convert_to_string(time, format)
          return result unless after_effect

          after_effect.call(self, result)
        end

        def convert_format
          XlsFunction::Converters::TimeConverter.convert_format(modified_source, ampm_mode: ampm_mode)
        end

        def ampm_mode
          flags[:ampm]
        end

        def modified_source
          minute_mode ? source.upcase : source.downcase
        end

        def convert_to_string(time, format)
          if format.start_with?('%J')
            time.to_date.strftime(format)
          else
            time.strftime(format)
          end
        end

        # ↓ after_effects: treat formats not covered by strftime
        def month(value)
          return value[1..] if source == 'm' && value.start_with?('0')
          return value[0] if source == 'mmmmm'

          value
        end

        def day(value)
          return value[1..] if source == 'd' && value.start_with?('0')

          value
        end

        def weekday(value)
          return ::XlsFunction::Converters::TimeConverter.convert_weekday_jp(value.to_i) if source == 'aaa'
          return "#{::XlsFunction::Converters::TimeConverter.convert_weekday_jp(value.to_i)}曜日" if source == 'aaaa'

          value
        end

        def wareki(value)
          return '元' if gannen && value == '1'
          return value.rjust(2, '0') if %w[ee r].include?(source)

          value
        end

        def gannen
          flags[:gannen]
        end

        def gengo(value)
          return ::XlsFunction::Converters::TimeConverter.convert_wareki_to_alphabet(value) if source == 'g'
          return value[0] if source == 'gg'

          value
        end

        def hour(value)
          return value[1..] if source == 'h' && value.length == 2 && value.start_with?('0')

          value
        end

        def minute(value)
          return value[1..] if source == 'm' && value.length == 2 && value.start_with?('0')

          value
        end

        def second(value)
          return value[1..] if source == 's' && value.length == 2 && value.start_with?('0')

          value
        end
      end
    end
  end
end
