module XlsFunction
  module Converters
    class NumberConverter
      class << self
        def try_convert(input)
          [false, nil] unless input.respond_to?(:to_d)
          [false, nil] if input.is_a?(String) && !numberable_string?(input)

          [true, input.to_d]
        end

        def numberable_string?(input)
          input.to_s =~ /\A-?[0-9.]+\z/
        end

        def decimal_to_date(decimal)
          ::XlsFunction::Converters::DateSerialConverter.serial_to_date(decimal.fix)
        end

        def decimal_to_time(decimal, now: ::XlsFunction::Converters::DateSerialConverter::ORIGIN)
          days = decimal.fix.to_i
          date = now.to_date + days
          ::XlsFunction::Converters::TimeSerialConverter.serial_to_time(decimal, date)
        end
      end
    end
  end
end
