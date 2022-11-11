module XlsFunction
  module Extensions
    module TimeExtension
      refine Time do
        def to_serial(except_date: false)
          ::XlsFunction::Converters::TimeSerialConverter.time_to_serial(self, except_date: except_date)
        end
      end
    end
  end
end
