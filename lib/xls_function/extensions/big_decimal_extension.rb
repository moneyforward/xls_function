module XlsFunction
  module Extensions
    module BigDecimalExtension
      refine BigDecimal do
        def to_date
          XlsFunction::Converters::NumberConverter.decimal_to_date(self)
        end

        def to_time(now: ::XlsFunction::Converters::DateSerialConverter::ORIGIN)
          XlsFunction::Converters::NumberConverter.decimal_to_time(self, now: now)
        end
      end
    end
  end
end
