module XlsFunction
  module Evaluators
    module Functions
      class DateFn < ::XlsFunction::Evaluators::FunctionEvaluator
        function_as :date

        define_arg :year
        define_arg :month
        define_arg :day

        using ::XlsFunction::Extensions::DateExtension

        def eval
          return ::XlsFunction::ErrorValue.num!(out_of_range) if year_i >= 10_000

          date = Date.new(year_value, 1, 1)
          date >>= month_value
          date += day_value

          date_value = date.to_serial
          return ::XlsFunction::ErrorValue.num!(out_of_range) if date_value.negative?

          date_value
        end

        def year_value
          year_i >= 1900 ? year_i : year_i + 1900
        end

        def month_value
          month_i - 1
        end

        def day_value
          day_i - 1
        end

        def year_i
          @year_i ||= year.to_i
        end

        def month_i
          @month_i ||= month.to_i
        end

        def day_i
          @day_i ||= day.to_i
        end

        def out_of_range
          message = error_message(:out_of_range, value: "#{year}, #{month}, #{day}")
          class_info(message)
        end
      end
    end
  end
end
