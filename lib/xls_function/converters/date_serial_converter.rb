module XlsFunction
  module Converters
    module DateSerialConverter
      ORIGIN = Date.new(1899, 12, 31).freeze

      class << self
        def date_to_serial(date)
          (date.to_date - ORIGIN).to_d(15)
        end

        def serial_to_date(serial)
          ORIGIN + serial.to_i
        end
      end
    end
  end
end
