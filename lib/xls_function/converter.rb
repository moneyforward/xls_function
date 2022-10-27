require 'xls_function/converters/date_serial_converter'
require 'xls_function/converters/time_serial_converter'
require 'xls_function/converters/number_converter'
require 'xls_function/converters/date_converter'
require 'xls_function/converters/time_converter'

module XlsFunction
  module Converter
    MAPS = {
      number: Converters::NumberConverter,
      date: Converters::DateConverter,
      time: Converters::TimeConverter
    }.freeze

    class << self
      def try_convert_to(type, value)
        converter = MAPS[type]
        return [false, "unsupported_type:#{type}"] unless converter

        converter.try_convert(value)
      end
    end
  end
end
