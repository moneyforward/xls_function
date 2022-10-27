module XlsFunction
  module Converters
    module TimeConverter
      class << self
        def try_convert(time_value)
          [true, convert(time_value)]
        rescue ArgumentError
          [false, invalid_time(time_value)]
        end

        def invalid_time(time_value)
          I18n.t('xls_function.errors.cannot_convert_to_time', source: time_value)
        end

        def convert(input)
          case input
          when Time
            input
          when Date
            input.to_time
          when BigDecimal
            NumberConverter.decimal_to_time(input)
          when Numeric
            Time.at(input)
          else
            parse(input)
          end
        end

        # @param [object] input
        # @param [Hash] cache context
        def convert_with_cache(input, cache)
          cache[:cache_convert_time] ||= {}
          cache[:cache_convert_time][input] ||= convert(input)
        end

        FORMAT_MAP = {
          'yyyy' => '%Y',
          'yy' => '%y',
          'm' => '%m',
          'mm' => '%m',
          'mmm' => '%b',
          'mmmm' => '%B',
          'mmmmm' => '%B',
          'd' => '%d',
          'dd' => '%d',
          'aaa' => '%w',
          'aaaa' => '%w',
          'ddd' => '%a',
          'dddd' => '%A',
          'e' => '%Jg',
          'ee' => '%Jg',
          'r' => '%Jg',
          'g' => '%Je',
          'gg' => '%Je',
          'ggg' => '%Je',
          'hh' => '%H',
          'h' => '%H',
          'M' => '%M',
          'MM' => '%M',
          's' => '%S',
          'ss' => '%S',
          '.0' => '%1N',
          '.00' => '%2N',
          '.000' => '%3N'
        }.freeze

        def convert_format(format, ampm_mode: false)
          mapped = FORMAT_MAP[format]
          mapped = '%I' if mapped == '%H' && ampm_mode
          raise NotImplementedError, "#{format} is not supported" unless mapped

          mapped
        end

        WEEKDAYS_JP = %w[日 月 火 水 木 金 土].freeze

        def convert_weekday_jp(week_index)
          WEEKDAYS_JP[week_index]
        end

        WAREKI_ALPHABETS = {
          '明治' => 'M',
          '大正' => 'T',
          '昭和' => 'S',
          '平成' => 'H',
          '令和' => 'R'
        }.freeze

        def convert_wareki_to_alphabet(gengo)
          WAREKI_ALPHABETS[gengo] || ''
        end

        # Accepts elapsed time expression that Time.parse cannot parse.
        def parse(date, now = Time.now, &block)
          Time.parse(date, now, &block)
        rescue ArgumentError
          result = fix_elapsed_time(date, now)
          raise if result == :throw

          Time.parse(result, now, &block)
        end

        def fix_elapsed_time(time_value, now)
          h = Date._parse(time_value)
          return :throw if h.key?(:yday) # give up when yday exists.
          return :throw if !h.key?(:sec) && !h.key?(:min) && !h.key?(:hour) # give up when not elapsed time expression.

          time_str, elapsed_day = fixed_time_str(h)
          date_str = fixed_date_str(h, now, elapsed_day)
          "#{date_str} #{time_str}"
        end

        def fixed_time_str(parsed)
          sec = parsed.fetch(:sec, 0)
          min = parsed.fetch(:min, 0)
          hour = parsed.fetch(:hour, 0)

          adjusted = adjust_elapsed_time(hour, min, sec)

          [
            "#{adjusted[:hour]}:#{adjusted[:minute]}:#{adjusted[:second]}#{sec_fraction_str(parsed)}#{zone_str(parsed)}",
            adjusted[:day]
          ]
        end

        def fixed_date_str(parsed, now, elapsed_day)
          year = parsed.fetch(:year, now.year)
          month = parsed.fetch(:mon, now.month)
          day = parsed.fetch(:mday, now.day)
          date = Date.new(year, month, day) + elapsed_day

          "#{date.year}-#{date.month}-#{date.day}"
        end

        def sec_fraction_str(parsed)
          return '' unless parsed.key?(:sec_fraction)

          ".#{(parsed[:sec_fraction] * 1000).to_i.to_s.rjust(3, '0')}"
        end

        def zone_str(parsed)
          return '' unless parsed.key?(:zone)

          " #{parsed[:zone]}"
        end

        def adjust_elapsed_time(hour, minute, second)
          elapsed_minute, s = second.divmod(60)
          elapsed_hour, m = (minute + elapsed_minute).divmod(60)
          elapsed_day, h = (hour + elapsed_hour).divmod(24)

          { day: elapsed_day, hour: h, minute: m, second: s }
        end
      end
    end
  end
end
