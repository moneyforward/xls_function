module XlsFunction
  module Extensions
    module DateExtension
      refine Date do
        def to_serial
          ::XlsFunction::Converters::DateSerialConverter.date_to_serial(self)
        end
      end
    end
  end
end
