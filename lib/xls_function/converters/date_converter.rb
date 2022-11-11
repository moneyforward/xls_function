module XlsFunction
  module Converters
    module DateConverter
      class << self
        def try_convert(date_value)
          [true, convert(date_value)]
        rescue Date::Error
          [false, invalid_date(date_value)]
        end

        def invalid_date(date_value)
          I18n.t('xls_function.errors.cannot_convert_to_date', source: date_value)
        end

        def convert(obj)
          case obj
          when Date
            obj
          when Time
            obj.to_date
          when BigDecimal
            NumberConverter.decimal_to_date(obj)
          else
            Date.parse(obj)
          end
        end
      end
    end
  end
end
