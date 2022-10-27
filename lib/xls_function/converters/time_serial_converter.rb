module XlsFunction
  module Converters
    module TimeSerialConverter
      H_UNIT = (BigDecimal('1') / 24)
      M_UNIT = (H_UNIT / 60)
      S_UNIT = (M_UNIT / 60)
      MS_UNIT = (S_UNIT / 1000)

      ORIGIN_TIME = Time.new(1899, 12, 31, 0, 0, 0).freeze

      class << self
        def time_to_serial(time, except_date: false)
          (except_date ? 0 : DateSerialConverter.date_to_serial(time.to_date)) +
            (
              hour_value_of(time) +
              minute_value_of(time) +
              second_value_of(time) +
              millisecond_value_of(time)
            ).round(15)
        end

        # @param [BigDecimal] time_serial
        def serial_to_time(time_serial, now = ORIGIN_TIME)
          Time.parse(TimeSerial.new(time_serial).to_s, now.to_time)
        end

        private

        def hour_value_of(time)
          time.hour * H_UNIT
        end

        def minute_value_of(time)
          time.min * M_UNIT
        end

        def second_value_of(time)
          time.sec * S_UNIT
        end

        def millisecond_value_of(time)
          time.usec.to_s.rjust(6, '0')[0, 3].to_i * MS_UNIT
        end
      end

      class TimeSerial
        attr_reader :serial

        def initialize(serial)
          @serial = serial.frac
        end

        def hour
          @hour ||= (serial / H_UNIT).round(15).to_i
        end

        def minute
          @minute ||= (without_hour / M_UNIT).round(15).to_i
        end

        def second
          @second ||= (without_hour_and_minute / S_UNIT).round(15).to_i
        end

        def millisecond
          @millisecond ||= (without_hour_and_minute_and_second / MS_UNIT).round(15).to_i
        end

        def to_s
          "#{pad_zero(&:hour)}:#{pad_zero(&:minute)}:#{pad_zero(&:second)}#{millisecond_suffix}"
        end

        private

        def without_hour
          serial - (H_UNIT * hour)
        end

        def without_hour_and_minute
          without_hour - (M_UNIT * minute)
        end

        def without_hour_and_minute_and_second
          without_hour_and_minute - (S_UNIT * second)
        end

        def pad_zero(count = 2, &block)
          block.call(self).to_s.rjust(count, '0')
        end

        def millisecond_suffix
          millisecond.zero? ? '' : ".#{pad_zero(3, &:millisecond)}"
        end
      end
    end
  end
end
