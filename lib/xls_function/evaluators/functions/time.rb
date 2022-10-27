module XlsFunction
  module Evaluators
    module Functions
      class TimeFn < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :time

        define_arg :hour, default: 0, type: :number
        define_arg :minute, default: 0, type: :number
        define_arg :second, default: 0, type: :number

        ARG_LIMIT = 32_767

        using ::XlsFunction::Extensions::TimeExtension

        def eval
          return ::XlsFunction::ErrorValue.num!(out_of_range) unless validate_args

          adjusted = ::XlsFunction::Converters::TimeConverter.adjust_elapsed_time(hour_i, minute_i, second_i)
          time = Time.new(Time.now.year, nil, nil, adjusted[:hour], adjusted[:minute], adjusted[:second])

          time.to_serial(except_date: true)
        end

        def validate_args
          return false if hour_i > ARG_LIMIT || minute_i > ARG_LIMIT || second_i > ARG_LIMIT

          # raise error when negative converted to seconds
          hour_sec = hour_i * 60 * 60
          minute_sec = minute_i * 60
          return false if (hour_sec + minute_sec + second_i).negative?

          true
        end

        def hour_i
          @hour_i ||= hour.to_i
        end

        def minute_i
          @minute_i ||= minute.to_i
        end

        def second_i
          @second_i ||= second.to_i
        end

        def out_of_range
          message = error_message(:out_of_range, value: "#{hour}, #{minute}, #{second}")
          class_info(message)
        end
      end
    end
  end
end
